require 'sinatra'
require 'yaml'

config = YAML.load_file('config.yml')

say = lambda do
  if params && words=params[:words] && config['whitelist_keys'].include?(params[:token])
    `say #{words}`
  end
end

get '/say', &say
post '/say', &say
