require 'sinatra'
require 'yaml'
require 'ipaddr'
require 'pstore'

class AinsleyTwo < Sinatra::Base
  config = YAML.load_file('config.yml')
  store = PStore.new('whitelist.pstore')

  say = lambda do
    if params && store.transaction{ store["#{params[:user]}"] } == params[:token]
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
    halt 422, 'Error 422: missing user param' unless params[:user]
    if subnet = config['subnet']
      internal = IPAddr.new(subnet)
      incoming = IPAddr.new(request.ip)
      if internal.include?(incoming)
        key = SecureRandom.hex
        store.transaction do
          store["#{params[:user]}"] = key
        end
        key
      end
    end
  end
end
