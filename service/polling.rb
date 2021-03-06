require 'net/http'
require 'uri'
require 'json'
require 'mongo'
load 'service/sms.rb'
load 'helpers/HttpUri.rb'

include HttpUri
include Mongo

class Polling  
  def process()
    mongo = Mongo::Connection.from_uri("mongodb://#{settings.mongo_un}:#{settings.mongo_pw}@flame.mongohq.com:27075/#{settings.mongo_db}")
    db = mongo.db(settings.mongo_db)
    
    uri = "http://pipes.yahoo.com/pipes/pipe.run?_id=ac45e9eb9b0174a4e53f23c4c9903c3f&_render=json&statustitle=logo&username=%40fcotravel"
    response = HttpUri.get_response(uri)
    results =  JSON.parse(response.body)
    
    results['value']['items'].each do |status|
      country_alert =  status['title'][/#\w+/]
      
      if(country_alert != nil) 
        puts country_alert.sub('#', '').downcase
        matched_users = db['user'].find({"destination" => country_alert.sub('#', '').downcase})
        
        matched_users.each do |user|
          puts user['email']

          sms_client = SMS.new
          sms_client.send(user['number'], status['title'])

          puts "sms sent to #{user['number']}"
        end
      end
    end
    
  end
end