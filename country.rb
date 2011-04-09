require 'net/http'
require 'uri'
require 'json'


response = Net::HTTP.get_response(URI.parse("http://fco.innovate.direct.gov.uk/countries.json"))
results =  JSON.parse(response.body)

results.each do |result|
  puts result['country']['name']
end