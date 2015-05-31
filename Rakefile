require 'rubygems'
require 'bundler/setup'

require 'pg'
require 'yaml'

# Rakefile
require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require './app/routes.rb'
  end
end

namespace :scrape do

  desc 'Scrape data from openuserjs.org'
  task :open_user_js do
    require './open_user_js_scraper.rb'
    OpenUserJsScraper.new.scrape
  end

end
