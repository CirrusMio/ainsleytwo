require 'sinatra'

class AinsleyTwo < Sinatra::Base
  users = {
    todd: 'bbc2ef86a33282c490c90714c5ae09a0',
    nick: 'bbc24fa7982b62ee333d519082ff47f1',
    steev: '9b7d14fdc931d6e0c3f801e948016819',
    sarah: '797c191a2c25d41bf5c6ba516c6a485d',
    mike: 'c2d9c4e37e06037c3051c31772de6aa3',
    chase: '8d181bfc818b3bf452b9f32d38390d43',
    chaserx: 'a4713062efaeb3bd0241cd6d1f56ce78'
  }

  say = lambda do
    if params && users.has_value?(params[:secret])
      `say #{params[:words]}`
    else
      halt 403
    end
  end

  get '/say', &say
  post '/say', &say
end
