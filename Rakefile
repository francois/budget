require File.dirname(__FILE__) + "/budget"
require "rake/testtask"
Sinatra.application.options.run = false
Dir[APP_ROOT + "lib/tasks/**/*.rake"].each {|f| load f}

namespace :db do
  task :migrate do
    ActiveRecord::Migrator.up(APP_ROOT + "db/migrations")
  end

  namespace :schema do
    desc "Create a db/schema.rb file that can be portably used against any DB supported by AR"
    task :dump do
      require "active_record/schema_dumper"
      File.open(APP_ROOT + "db/schema.rb", "w") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end

    desc "Load a schema.rb file into the database"
    task :load do
      load(APP_ROOT + "db/schema.rb")
    end
  end

  namespace :test do
    desc "Recreate the test database from the current environment's database schema"
    task :clone => %w(db:schema:dump) do
      ActiveRecord::Base.establish_connection(:adapter => "mysql", :database => "budget_development", :username => "root", :encoding => "utf8")
      ActiveRecord::Schema.verbose = false
      Rake::Task["db:schema:load"].invoke
    end

    desc "Empty the test database"
    task :purge do
    end

    desc "Prepare the test database and load the schema"
    task :prepare => %w(db:test:clone db:test:purge)
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

namespace :test do
  Rake::TestTask.new(:units => "db:test:prepare") do |t|
    t.libs << "test"
    t.pattern = "test/unit/**/*_test.rb"
    t.verbose = true
  end
  Rake::Task["test:units"].comment = "Run the unit tests in test/unit"
end

task :default => "test:units"
