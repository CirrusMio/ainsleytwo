require_relative '../lib/authentication.rb'
class Playlist < Sinatra::Base
  include Authentication

  configure do
    enable :logging
    file = File.new(File.expand_path('log/ainsleytwo.log'), 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  # POST /door/front/bell?token=abc123
  # POST /door/front/ajar?token=abc123
  # Deprecated. But here to preserve backwards compatibility for the moment.
  post '/door/:position/:action' do
    playlist = "sounds/playlist/#{params[:position]}_door_#{params[:action]}"
    play playlist
  end

  # Deprecated.
  get '/door/:position/:action' do
    halt 422, "You must use POST for door notifications."
  end

  # POST /playlist/front_door_ajar?token=abc123
  post '/playlist/:playlist' do
    playlist = "sounds/playlist/#{params[:playlist]}"
    play playlist
  end

  get '/playlist/:playlist' do
    halt 422, "You must use POST for playlists."
  end

  def play playlist
    if authenticate params[:token]
      `mplayer -playlist #{playlist}`
    else
      halt 403
    end
  end
end
