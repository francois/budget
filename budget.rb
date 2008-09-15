require "rubygems"
gem "sinatra", "~> 0.3"
require "sinatra"
gem "activerecord", "~> 2.1"
require "activerecord"
require "pathname"
require "money"

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
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => APP_ROOT + "db/test.db")
end

Dir[APP_ROOT + "vendor/plugins/**/init.rb"].each do |file|
  $:.unshift << File.dirname(file) + "/lib"
  require file
end

error ActiveRecord::RecordNotFound do
  status 404
  header "Content-Type" => "text/plain; charset=UTF-8"
  "Unknown object, or object not found"
end

get "/accounts" do
  header "Content-Type" => "application/javascript; charset=UTF-8"
  Account.all.to_json
end

post "/accounts" do
  header "Content-Type" => "application/javascript; charset=UTF-8"
  account = Account.create!(params)
  account.to_json
end

put "/account/:id" do
  header "Content-Type" => "application/javascript; charset=UTF-8"
  account = Account.find(params.delete("id"))
  account.update_attributes!(params)
  account.to_json
end

delete "/account/:id" do
  header "Content-Type" => "application/javascript; charset=UTF-8"
  account = Account.find(params.delete("id"))
  account.destroy
  account.to_json
end
