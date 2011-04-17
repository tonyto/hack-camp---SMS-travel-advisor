require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo'
require 'net/http'
require 'uri'
require 'json'

Dir["./helpers/*.rb"].each {|file| require file }
Dir["./routes/*.rb"].each {|file| require file }

set :environment, :development
set :mongo_db, ENV['MONGO_DB']
set :mongo_un, ENV['MONGO_UN']
set :mongo_pw, ENV['MONGO_PW']
set :sms_un, ENV['MONGO_UN']
set :sms_pw, ENV['MONGO_PW']