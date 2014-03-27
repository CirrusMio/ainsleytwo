class DoorKnocker < Sinatra::Base
  # POST /door/front/bell?token=abc123
  # POST /door/front/ajar?token=abc123
  post '/door/:position/:action' do
    # play proper playlist by params
    playlist = "sounds/playlist/#{params[:position]}_door_#{params[:action]}"
    # if params && whitelist.include?(params[:token])
      `mplayer -playlist #{playlist}`
    # else
    #   halt 403
    # end
  end
end
