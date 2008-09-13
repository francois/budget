require File.dirname(__FILE__) + "/budget"
Sinatra.application.options.run = false
Dir[APP_ROOT + "lib/tasks/**/*.rake"].each {|f| load f}

namespace :db do
  task :migrate do
    ActiveRecord::Migrator.up(APP_ROOT + "db/migrations")
  end
end

namespace :gen do
  task :migration do
    name = ENV["NAME"]
    File.open(APP_ROOT + "db/migrations/%s_%s.rb" % [Time.now.utc.strftime("%Y%m%d%H%M%S"), name], "w") do |io|
      io.puts "class #{name.camelize} < ActiveRecord::Migration"
      io.puts "  def self.up"
      io.puts "  end"
      io.puts
      io.puts "  def self.down"
      io.puts "  end"
      io.puts "end"
    end
  end
end
