desc 'Run a development server.'
task :dev do
  sh 'shotgun -Ilib -p 4567 app.rb'
end

task :default => 'tweets'

desc 'Fetch new tweets.'
task :tweets do
  sh 'ruby -Ilib bin/capturetweets.rb'
end

desc 'Show tweets.'
task :show do
  sh 'sqlite3 tweets.db "select * from tweets;"'
end

desc 'Clear tweets db.'
task :clear do
  sh 'rm tweets.db'
end
