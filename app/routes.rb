require 'sinatra'
require 'sinatra/jsonp'
require 'sinatra/cross_origin'

require_relative '../db_connector'

set :protection, :except => :json_csrf

get '/scripts' do
  cross_origin

  url = params[:url]
  host_name_pattern = "%#{URI(url).host.split('.').first}%"

  scripts = Script.joins(:inclusions).where(':url like inclusions.pattern and inclusions.pattern like :host_name_pattern',
    {url: url, host_name_pattern: host_name_pattern})

  response = {
    scripts: scripts
  }

  JSONP response
end
