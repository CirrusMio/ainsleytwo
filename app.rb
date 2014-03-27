require 'sinatra'
require 'yaml'
require 'ipaddr'
require 'active_support/all'
Dir.glob('handlers/*.rb').each do |file|
  require_relative File.expand_path(file)
end

class AinsleyTwo < Sinatra::Base
  Dir.glob('handlers/*.rb').each do |file_name|
    use File.basename(file_name, '.rb').camelize.constantize
  end

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
end
