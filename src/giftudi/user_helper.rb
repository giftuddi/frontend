module UserHelper
  def signed_in?
    session[:user_id]
  end

  def user
    @user ||= User.find session[:user_id]
  end

  def sign_in user
    session[:user_id] = user.id
  end

end