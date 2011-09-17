require 'rubygems'
require 'sinatra'
require 'pp'
require 'model'
require 'haml'
require 'sass'

configure do
  # Configure HAML and SASS
  set :haml, { :format => :html5 }
  set :sass, { :style => :compressed } if ENV['RACK_ENV'] == 'production'
end

get '/' do
  @tweets = Tweet.all(:order => [:created_at.desc])
  haml :index
end
