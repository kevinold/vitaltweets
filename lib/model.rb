require 'dm-core'
require 'dm-sqlite-adapter'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tweets.db")

class Tweet
  include DataMapper::Resource
  property :id,         Serial
  property :tweet_id,   String
  property :tweet_text, String, :length => 255
  property :screen_name, String
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

