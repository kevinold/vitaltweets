VitalTweets
=========

I have deemed tweets I consider to be life changing or of such importance that I would hate to have missed it "vital".  That said, I follow a lot of people and can get behind on weekends or days when I am too busy to check Twitter for what is going on.  I find that I'd really only like to keep up with subset of tweets based on various keywords.  This is a tool to do that.

Tweets are captured via a script (cron to run every few minutes).  Matching tweets are placed into a SQLite database.  A simple Sinatra app allows for quick review and link to original tweet.

Quick Start
---------

    bundle install
    edit config/twitter.yml with config data from dev.twitter.com
    edit bin/capturetweets.rb to adjust INCLUDE_KEYWORDS
    run bin/capturetweets.rb # or rake tweets
    rake server #launch sinatra app to view captured tweets
    visit localhost:4567

TODO
---------

Lots.

Cleanup web UI.
Add bayesian classification system.
Switch to browser based OAuth logic for user (for "hosted" solution)
Etc.
