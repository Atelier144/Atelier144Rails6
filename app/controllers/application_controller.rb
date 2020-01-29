class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    session[:user_id] = nil if @current_user.nil?
  end

  def authenticate_user
    unless @current_user
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end
  
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/")
    end
  end
    
  def does_exist_user
    unless User.find_by(id: params[:id])
      flash[:notice] = "そのアカウントは存在しません"
      redirect_to("/")
    end
  end

  def set_twitter_client
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter_api[:key]
      config.consumer_secret = Rails.application.credentials.twitter_api[:secret_key]
      config.access_token = @current_user.twitter_access_token
      config.access_token_secret = @current_user.twitter_access_token_secret
    end
  end
end
