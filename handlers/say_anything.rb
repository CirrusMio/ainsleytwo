require_relative '../lib/authentication.rb'
class SayAnything < Sinatra::Base
  include Authentication

  configure do
    enable :logging
    file = File.new(File.expand_path('log/sinatra.log'), 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  before '/say/*' do
    if authenticate(params[:token])
    else
      halt 403, haml('Access Denied')
    end
  end

  say = lambda do
    `say #{params[:words]}` if params
  end

  get '/say', &say
  post '/say', &say
end
