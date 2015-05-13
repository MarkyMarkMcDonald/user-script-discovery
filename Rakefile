require 'rubygems'
require 'bundler/setup'

require 'pg'
require 'active_record'
require 'yaml'
require './open_user_js_scraper.rb'

namespace :db do

  desc 'Migrate the db'
  task :migrate do
    project_root = File.dirname(File.absolute_path(__FILE__))
    Dir.glob(project_root + '/app/models/*.rb').each{|f| require f}

    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migrator.migrate('db/migrate/')
  end

  desc 'Create the db'
  task :create do
    connection_details = YAML::load(File.open('config/database.yml'))
    admin_connection = connection_details.merge({'database'=> 'postgres', 
                                                'schema_search_path'=> 'public'}) 
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
  end

  desc 'drop the db'
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    admin_connection = connection_details.merge({'database'=> 'postgres', 
                                                'schema_search_path'=> 'public'}) 
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
  end
end

namespace :scrape do

  desc 'Scrape data from openuserjs.org'
  task :open_user_js do
    OpenUserJsScraper.new.scrape
  end

end
