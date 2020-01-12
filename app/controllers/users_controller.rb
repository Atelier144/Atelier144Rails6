class UsersController < ApplicationController
  def profile
  end

  def login_form
  end

  def signup_form
  end

  def profile_form
  end

  def profile_done
  end

  def email_form
  end

  def email_done
  end

  def email_create_done
  end

  def password_form
  end

  def password_done
  end

  def sns_form
  end

  def sns_done
  end

  def records_form
  end

  def records_done
  end

  def forgot_password_form
  end

  def forgot_password_done
  end

  def reset_password_form
  end

  def reset_password_done
  end

  def twitter
    auth_hash = request.env["omniauth.auth"]
    @provider = auth_hash[:provider]
    @uid = auth_hash[:uid]
    @name = auth_hash[:info][:name]
    @image = auth_hash[:info][:image]
    @description = auth_hash[:info][:description]
    @url = auth_hash[:info][:urls][:Website]
    @twitter_url = auth_hash[:info][:urls][:Twitter]
  end
end
