$: << File.dirname(__FILE__) unless $:.include? File.dirname(__FILE__)

require 'sinatra/base'
require 'config'
require 'giftudi/user'

class App < Sinatra::Base
  set :sessions, true

  get '/' do
    erb :index
  end

  post '/login' do
    u = User.authenticate params[:email], params[:password]
  end
end