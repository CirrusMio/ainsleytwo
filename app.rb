require 'sinatra'
require 'yaml'
require 'ipaddr'

class AinsleyTwo < Sinatra::Base
  config = YAML.load_file('config.yml')
  whitelist = YAML.load_file('whitelist.yml')

  say = lambda do
    if params && whitelist.include?(params[:token])
      `say #{params[:words]}`
    else
      halt 403
    end
  end

  get '/say', &say
  post '/say', &say

  # Return a key if the incoming request is from an internal network
  # Save the key to the whitelist
  get '/key' do
    if subnet=config['subnet']
      internal = IPAddr.new(subnet)
      incoming = IPAddr.new(request.ip)
      if internal.include?(incoming)
        key = SecureRandom.hex
        whitelist ||= []
        whitelist.push(key)
        File.open('config.yml', 'w') {|f| f.write(whitelist.to_yaml) }
        key
      end
    end
  end

  # POST /door/front/bell?token=abc123
  # POST /dorr/front/ajar?token=abc123
  post '/door/:position/:action' do
    # play proper playlist by params
    playlist = "sounds/playlist/#{params[:position]}_door_#{params[:action]}"
    if params && whitelist.include?(params[:token])
      `mplayer -playlist #{playlist}`
    else
      halt 403
    end
  end
end
