require 'sinatra'

get '/say' do
  if params && words=params["words"]
    `say #{words}`
  end
end
