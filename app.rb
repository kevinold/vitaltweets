require 'rubygems'
require 'sinatra'
require 'pp'
require 'haml'
require 'sass'
require 'model'
require 'vitaltweets'

configure do
  # Configure HAML and SASS
  set :haml, { :format => :html5 }
  set :sass, { :style => :compressed } if ENV['RACK_ENV'] == 'production'
end

helpers do
  def linkify_and_bold(tweet)
    # linkify links in tweet
    tweet = tweet.gsub /((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/, %Q{<a href="\\1">\\1</a>}

    # surround match keywords with bold
    tweet = tweet.gsub VitalTweets::INCLUDE_REGEXP, %Q{<b>\\1</b>}
  end
end

get '/' do
  @tweets = Tweet.all(:order => [:created_at.desc])
  haml :index
end
