require 'sinatra/base'
require 'rack/csrf'

require 'config'
require 'giftudi/user'

class App < Sinatra::Base
  use Rack::Session::Cookie, :secret => "c6df3852815c219b16f51db428662aef"
  use Rack::Csrf, :raise => true

  get '/' do
    erb :index
  end

  post '/login' do
    u = User.authenticate params[:email], params[:password]
    if u
      session[:user_id] = u.id
      redirect to("/")
    else
      
    end
  end
end