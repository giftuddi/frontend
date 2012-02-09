require 'sinatra'
require 'config'
require 'giftudi/user'

configure do

end

get '/' do
  erb :index
end

post '/login' do
  u = User.authenticate params[:email], params[:password]
  
end
