require 'sinatra/base'
require 'rack/csrf'

require 'config'
require 'giftudi/user'
require 'giftudi/helpers'
require 'facebook_app'

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

end