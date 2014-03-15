require 'faraday'

URL_FORMAT = "/BB0728CC-D37B-46C1-A230-4DCA02826ED3_29F2216D-E18F-437F-998D-7D8EC7009B66/nowplaying/songs?date=%s&tz=300"


def each_day
  start_date = Time.now
  end_date = Time.new(2013,9,3)  #Time.now - 1.month

  date = start_date
  begin
    yield date
    date -= 1.day
  end while date >= end_date
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

def artist(artist_name)
  Artist.where(name:artist_name).first_or_create
end

desc "import last 30 days"
task :import => :environment do
  each_day do |date|
    url = URL_FORMAT % date.strftime('%F')
    puts "getting #{url}"
    data = JSON.parse(fetch(url))
    data["songs"].each do |song_params|
      id = song_params["timestamp"]
      artist = artist(song_params["songartist"])
      params = song_params.merge(id: id)
      params.delete('timestamp')
      song = Song.find_or_create_by(id:id)
      song.update_attributes params.merge(artist:artist)
    end
  end
end

