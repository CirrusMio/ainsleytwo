require 'sinatra'

get '/say' do
  if params && words=params[:words]
    `say #{words}`
  end
end

post '/say' do
  if params && words=params[:words]
    `say #{words}`
  end
end
