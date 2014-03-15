require 'active_support/all'
require 'faraday'

URL_FORMAT = "/BB0728CC-D37B-46C1-A230-4DCA02826ED3_29F2216D-E18F-437F-998D-7D8EC7009B66/nowplaying/songs?date=%s&tz=300"

# puts URL_FORMAT % '2014-02-22'
# puts URL_FORMAT % Time.now.strftime('%F')


def each_day
  start_date = Time.now
  end_date = Time.now - 1.month

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
  puts response.body
end


each_day do |date|
  url = URL_FORMAT % date.strftime('%F')
  puts url
  puts fetch url
end