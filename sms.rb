require 'net/http'
require 'uri'

class SMS
  def send(number, message)
    message = URI.escape(message, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    
    uri = "http://api.clickatell.com/http/sendmsg?user=antony.denyer&password=7digital&api_id=3300001&to=#{number}&text=#{message}"
    
    
    puts uri
    
    get_response(uri)
  end

  private
  def get_response(uri)
    Net::HTTP.get_response(URI.parse(uri))
    puts "done yo!!!"
  end
end
