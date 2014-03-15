require 'sinatra'

SECRET_KEY="26289216d0613f8978b7d2cf64f27914"

get '/say' do
  if params && words=params[:words] && params[:secret] == SECRET_KEY
    `say #{words}`
  end
end

post '/say' do
  if params && words=params[:words] && params[:secret] == SECRET_KEY
    `say #{words}`
  end
end
