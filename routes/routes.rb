include HttpUri
include Mongo

mongo = Mongo::Connection.from_uri("mongodb://#{settings.mongo_un}:#{settings.mongo_pw}@flame.mongohq.com:27075/#{settings.mongo_db}")
db = mongo.db(settings.mongo_db)
 
get '/' do
  response = HttpUri.get_response("http://fco.innovate.direct.gov.uk/countries.json")
  countries =  JSON.parse(response.body)
  
  haml :index, :locals => {:countries => countries}
end

post '/' do
  params[:number][0] = "44"
  details = {'name' => params[:name], 'email' => params[:email], 'number' => params[:number], 'destination' => params[:destination].downcase, 'return_date' => params[:return_date]}
  db['user'].insert(details)
  
  redirect "/alert?country=#{params[:destination]}"
end

get '/alert?:destination' do
  request_uri = "http://fco.innovate.direct.gov.uk/countries/#{params[:country]}/travel_advice_summary.json"
  response = HttpUri.get_response(request_uri)
  response_body = JSON.parse(response.body)
  puts request_uri
  
  title = response_body['travel_advice_section']['title']
  summary = response_body['travel_advice_section']['body']['markup']
  
  haml :alert, :locals => {:title => title, :summary => summary}
end