require 'sinatra/base'
require 'facebook_oauth'
require 'config'

class App < Sinatra::Base

  def signed_in?
    logger.info "signed_in => #{session[:fb]}"
    session[:fb] != nil
  end

  def full_name
    if session[:full_name] then 
      session[:full_name]
    else 
      session[:full_name] = fb.me.info['name']
    end    
    session[:full_name]
  end

  def fb
    uri = URI.parse(request.url)
    uri.path = '/auth/facebook/callback'
    uri.query = nil
    redirect_uri = uri.to_s

    if session[:fb]
      logger.info session[:fb]
      @fb ||= FacebookOAuth::Client.new(
        :application_id => Config["fb"]["app_id"],
        :application_secret => Config["fb"]["secret_key"],
        :token => session[:fb],
        :callback => redirect_uri
      )
      logger.info @fb.inspect
    else
      @fb ||= FacebookOAuth::Client.new(
        :application_id => Config["fb"]["app_id"],
        :application_secret => Config["fb"]["secret_key"],
        :callback => redirect_uri
      )  
    end 
    @fb
  end

  get '/auth/facebook' do
    redirect to(fb.authorize_url, scope: "email")
  end

  get '/auth/facebook/callback' do
    code = params[:code]
    access_token = fb.authorize(:code => code)
    logger.info fb.me.info['name']
    logger.info access_token.token
    session[:fb] = access_token.token
    redirect to("/")
  end

end
