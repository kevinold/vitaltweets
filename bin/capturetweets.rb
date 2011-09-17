$LOAD_PATH << File.expand_path(File.join(*%w[ .. lib ]), File.dirname(__FILE__))

require 'rubygems'
require 'twitter'
require 'pp'
require 'yaml'
require 'model'
require 'vitaltweets'

DEBUG = false

# Get these from setting up a new application at dev.twitter.com
CLIENT = Twitter::Client.new(:format => 'json',
                             :consumer_key => VitalTweets::CONFIG["consumer_key"],
                             :consumer_secret => VitalTweets::CONFIG["consumer_secret"],
                             :oauth_token => VitalTweets::CONFIG["oauth_token"],
                             :oauth_token_secret => VitalTweets::CONFIG["oauth_token_secret"]
                            )

# loop over home timeline
CLIENT.home_timeline.each do |t|
  tweet_id = t.id
  tweet_text = t.text
  screen_name = t.user["screen_name"]

  #has_link = Regexp.new(%Q(http://))

  # next if contains strings to exclude
  next if Regexp.union(VitalTweets::EXCLUDE_KEYWORDS) =~ tweet_text

  if (tweet_text.match(VitalTweets::INCLUDE_REGEXP))

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

