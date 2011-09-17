require 'rubygems'
require 'twitter'
require 'pp'
require 'model'
require 'yaml'

DEBUG = false
CONFIG = YAML::load_file('config/twitter.yml')

# Get these from setting up a new application at dev.twitter.com
CLIENT = Twitter::Client.new(:format => 'json',
                             :consumer_key => CONFIG["consumer_key"],
                             :consumer_secret => CONFIG["consumer_secret"],
                             :oauth_token => CONFIG["oauth_token"],
                             :oauth_token_secret => CONFIG["oauth_token_secret"]
                            )

INCLUDE_KEYWORDS = ["rails", "ruby", "coffee", "github", "cloud", "apple", "css",
                    "design", "gem", "git", "html5", "javascript", "jquery", "js", "json",
                    "mac", "mobile", "mongo", "nosql", "node", "sass", "vim", "backbone"]
EXCLUDE_KEYWORDS = []

INCLUDE_REGEXP = Regexp.new(Regexp.union(INCLUDE_KEYWORDS).source, Regexp::IGNORECASE)

# loop over home timeline
CLIENT.home_timeline.each do |t|
  tweet_id = t.id
  tweet_text = t.text
  screen_name = t.user["screen_name"]

  #has_link = Regexp.new(%Q(http://))

  # next if contains strings to exclude
  next if Regexp.union(EXCLUDE_KEYWORDS) =~ tweet_text

  if (tweet_text.match(INCLUDE_REGEXP))

    # linkify links in tweet
    tweet_text = tweet_text.gsub /((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/, %Q{<a href="\\1">\\1</a>}

    if (DEBUG)
      puts tweet_id, tweet_text, screen_name
      pp t 
    end

    # Write tweet to database
    Tweet.first_or_create({ :tweet_id => tweet_id}, { 
      :tweet_id => tweet_id, 
      :tweet_text => tweet_text, 
      :screen_name => screen_name, 
      :created_at => Time.now })
  end
end

