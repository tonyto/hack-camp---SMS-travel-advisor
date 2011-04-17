require 'net/http'
require 'uri'

load 'helpers/HttpUri.rb'

include HttpUri

class SMS
  def send(number, message)
    message = URI.escape(message, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    
    uri = "http://api.clickatell.com/http/sendmsg?user=#{settings.sms_un}&password=#{settings.sms_pw}&api_id=3300001&to=#{number}&text=#{message}"
    HttpUri.get_response(uri)
    puts "done"
  end
end
