require_relative '../lib/authentication.rb'
class DoorKnocker < Sinatra::Base
  include Authentication

  # POST /door/front/bell?token=abc123
  # POST /door/front/ajar?token=abc123
  post '/door/:position/:action' do
    # play proper playlist by params
    playlist = "sounds/playlist/#{params[:position]}_door_#{params[:action]}"
    if authenticate params[:token]
      `mplayer -playlist #{playlist}`
    else
      halt 403
    end
  end

  get '/door/:position/:action' do
    halt 422, "You must use POST for door notifications."
  end
end
