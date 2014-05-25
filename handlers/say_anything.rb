require_relative '../lib/authentication.rb'
class SayAnything < Sinatra::Base
  include Authentication

  before '/say/' do
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
