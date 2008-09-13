require "rubygems"
require "sinatra"
require "activerecord"
require "pathname"

configure do
  APP_ROOT = Pathname.new(File.dirname(__FILE__)).realpath
  Dir[APP_ROOT + "models/*.rb"].each {|f| require f}

  (APP_ROOT + "log").mkpath
  ActiveRecord::Base.logger = Logger.new(APP_ROOT + "log/#{Sinatra.env}.log")
end

configure :development do
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => APP_ROOT + "db/development.db")
end

configure :test do
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory")
end
