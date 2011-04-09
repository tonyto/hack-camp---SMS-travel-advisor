require 'net/http'
require 'uri'
require 'json'
require 'mongo'
load 'service/sms.rb'
load 'helpers/HttpUri.rb'

include HttpUri
include Mongo

class Polling  
  def process
    db = Connection.new('localhost', 27017).db('travelalerts')
    
    uri = "http://pipes.yahoo.com/pipes/pipe.run?_id=ac45e9eb9b0174a4e53f23c4c9903c3f&_render=json&statustitle=logo&username=%40fconotification"
    response = HttpUri.get_response(uri)
    results =  JSON.parse(response.body)

    results['value']['items'].each do |status|
      country_alert =  status['title'][/#\w+/]
      puts country_alert
  
      matched_users = db['user'].find({"destination" => country_alert.sub("#", "")})
  
      matched_users.each do |user| 
        puts user['email']
        
        sms_client = SMS.new
        sms_client.send(user['number'], status['title'])
        
        puts "sms sent to #{user['number']}"
      end
    end
  end
end