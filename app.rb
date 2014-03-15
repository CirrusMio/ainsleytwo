require 'sinatra'
require 'yaml'

class AinsleyTwo < Sinatra::Base
  config = YAML.load_file('config.yml')

  say = lambda do
    if params && config['whitelist_keys'].include?(params[:token])
      `say #{params[:words]}`
    else
      halt 403
    end
  end

  get '/say', &say
  post '/say', &say
end
