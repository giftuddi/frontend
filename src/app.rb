require 'sinatra/base'
require 'rack/csrf'

require 'config'
require 'giftudi/user'

module Env
  include UserRepo
  include BreadModule
end

class App < Sinatra::Base
  use Rack::Session::Cookie, :secret => "c6df3852815c219b16f51db428662aef"
  use Rack::Csrf, :raise => true

  include Env

  get '/' do
    u = users.authenticate "hello", "world"
    puts u
    erb :index
  end

  post '/login' do
    u = authenticate params[:email], params[:password]
    if u
      session[:user_id] = u.id
      redirect to("/")
    else
      
    end
  end
end