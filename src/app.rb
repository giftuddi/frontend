require 'sinatra/base'
require 'rack/csrf'

require 'config'
require 'giftudi/user'
require 'giftudi/helpers'

class App < Sinatra::Base
  use Rack::Session::Cookie, :secret => "c6df3852815c219b16f51db428662aef"
  use Rack::Csrf, :raise => true
  
  configure do
    enable :logging
  end

  include Helpers

  get '/' do
    pass unless signed_in?
    erb :home
  end

  get '/' do
    erb :splash
  end

  post "/user" do
    u = User.create params[:email], params[:password]
    logger.info u.inspect
    sign_in u
    redirect to("/")
  end

  post "/logout" do
    session[:user_id] = nil
    redirect to("/")
  end

  post '/login' do
    if u = User.authenticate(params[:email], params[:password])
      sign_in u
      redirect to("/")
    else
      halt 400
    end
  end
end