class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                   :uid => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:access_secret] = request.env['omniauth.auth']['credentials']['secret']
    redirect_to show_url, :notice => "Signed in"
  end
 
  def error
    flash[:error] = "Sign in with Twitter failed"
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end


