require 'rubygems'
require 'sinatra'
require 'pp'
require 'model'

get '/' do
  @tweets = Tweet.all(:order => [:created_at.desc])
  erb :index
end
