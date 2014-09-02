require 'faraday'

class Importer

  URL_FORMAT = "/BB0728CC-D37B-46C1-A230-4DCA02826ED3_29F2216D-E18F-437F-998D-7D8EC7009B66/nowplaying/songs?date=%s&tz=300"
  DEBUT = Date.new(2013,9,3)

  def enqueue_jobs
    today = Date.today

    dates = (DEBUT..today).map { |date| date }

    puts "getting existing song dates"
    Song.transaction do
      existing_songs = Song.where('date between ? and ?', DEBUT, today).select('date').distinct.map(&:date)
      puts existing_songs
      dates = dates - existing_songs
    end
    puts "without existing songs", dates

    puts "getting existing job dates"
    existing_jobs = FetchJob.where('date between ? and ?', DEBUT, today).select('date').distinct.map(&:date)

    jobs_to_create = dates - existing_jobs

    puts "creating jobs"
    jobs = FetchJob.transaction do
      jobs_to_create.map do |date|
        FetchJob.create! date:date
      end
    end

    puts "Created #{jobs.length} jobs."
  end

  def process_jobs
    importer = Importer.new

    while true
      puts "fetching"
      job = FetchJob.where(status: :enqueued).first

      if job.nil?
        puts "no more jobs"
        break
      end

      puts "processing #{job.inspect}"

      begin
        importer.process_date(job.date)
        job.update_attributes(status: :processed, last_message: nil)
      rescue => e
        job.update_attributes(status: :failed, last_message: e.message)
      end

      puts "waiting"
      sleep 10
    end
  end

  def process_date(date)
    url = URL_FORMAT % date.strftime('%F')
    puts "getting #{url}"
    data = JSON.parse(fetch(url))
    data["songs"].each do |song_params|
      id = song_params["timestamp"]
      artist = find_artist(song_params["songartist"])
      params = song_params.merge(id: id)
      params.delete('timestamp')
      song = Song.find_or_create_by!(id:id)
      song.update_attributes! params.merge(artist:artist, date:date)
    end
  end

  def fetch(url)
    conn = Faraday.new(:url => 'http://core.commotion.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get url
    response.body
  end

  def find_artist(artist_name)
    Artist.where(name:artist_name).first_or_create
  end

end
