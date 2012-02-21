class PagesController < ApplicationController
  def home
  end

  def show
    if session['access_token'] && session['access_secret']
      @twitteruser ||= client.user(:include_entities => true)
      @users ||= User.all
    else
      redirect_to failure_path
    end
  end

  def tweet
      Twitter.update(params[:t])
      redirect_to show_path
  end
end


