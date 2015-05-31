require 'sinatra/base'
require 'sinatra/jsonp'
require 'sinatra/cross_origin'
require 'sinatra/activerecord'

class UserScriptScraper < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  register Sinatra::CrossOrigin
  helpers Sinatra::Jsonp

  configure do
    enable :cross_origin
  end

  set :protection, :except => :json_csrf
  set :database_file, '../config/database.yml'
  set :logging, true

  require_relative '../app/models'

  get '/scripts' do
    url = params[:url]
    host_name_pattern = "%#{URI(url).host.split('.').first}%"

    scripts = Script.joins(:inclusions).where(':url like inclusions.pattern and inclusions.pattern like :host_name_pattern',
      {url: url, host_name_pattern: host_name_pattern})

    response = {
      scripts: scripts
    }

    puts "#{scripts.length} scripts found for #{url}"

    JSONP response
  end
end
