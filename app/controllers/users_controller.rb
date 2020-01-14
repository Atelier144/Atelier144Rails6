class UsersController < ApplicationController
  before_action :does_exist_user, only:[:profile]
  
  before_action :forbid_login_user, only:[
    :login, :login_form, 
    :signup, :signup_form,
    :forgot_password_form, :forgot_password, :forgot_password_done,
    :reset_password_form, :reset_password]
  
  before_action :authenticate_user, only:[
    :signup_done,
    :profile_form, :profile_update, :profile_done, 
    :email_form, :email_update, :email_done, :email_create, :email_create_done,
    :password_form, :password_update, :password_done,
    :sns_form, :sns_done,
    :records_form, :records_done, 
    :reset_password_done]


  def profile
    @user = User.find_by(id: params[:id])

    @infinite_blocks_record = InfiniteBlocksRecord.find_by(user_id: @user.id)
    @infinite_blocks_yearly_record = InfiniteBlocksYearlyRecord.where("updated_at >= ?", Date.today.prev_year(1)).find_by(user_id: @user.id)
    @infinite_blocks_monthly_record = InfiniteBlocksMonthlyRecord.where("updated_at >= ?", Date.today.prev_month(1)).find_by(user_id: @user.id)
    @infinite_blocks_weekly_record = InfiniteBlocksWeeklyRecord.where("updated_at >= ?", Date.today.prev_day(7)).find_by(user_id: @user.id)
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to("/")
    else
      flash[:email] = params[:email]
      flash[:warning] = "メールアドレスもしくはパスワードが間違っています"
      redirect_to("/login")
    end

  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end

  def signup_form
  end

  def signup
    name = params[:name]
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    is_genuine = "true"

    if name == ""
      is_genuine = nil
      flash[:name_warning] = "ユーザー名を入力してください"
    elsif User.find_by(name: name)
      is_genuine = nil
      flash[:name_warning] = "そのユーザー名は既に使用されています"
    else
      flash[:name] = name
    end

    if email == ""
      is_genuine = nil
      flash[:email_warning] = "メールアドレスを入力してください"
    elsif User.find_by(email: email)
      is_genuine = nil
      flash[:email_warning] = "そのメールアドレスは既に使用されています"
    else
      flash[:email] = email
    end

    if password.length < 8 || password.length > 32
      is_genuine = nil
      flash[:password_warning] = "8字以上、32字以下のパスワードを入力してください"
    else
      flash[:password] = password
    end

    if password != password_confirmation
      is_genuine = nil
      flash[:password_confirmation_warning] = "確認用のパスワードが一致しません"
    else
      flash[:password_confirmation] = password_confirmation
    end

    if is_genuine
      user = User.new(
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        description: "",
        url: "",
        is_published_profile: true,
        is_published_description: true,
        is_published_url: true,
        is_published_twitter_url: true,
        is_published_record: true
      )
      if user.save
        session[:user_id] = User.find_by(email: email).id
        redirect_to("/signup/done")
      else
        flash[:notice] = "新規登録に失敗しました"
        redirect_to("/signup")
      end
    else
      redirect_to("/signup")
    end
  end

  def signup_done

  end

  def profile_form
    user = @current_user
    if flash[:checked_profile] == "true" || (flash[:checked_profile].nil? && user.is_published_profile == true)
      @checked_profile = "checked"
    end
    if flash[:checked_description] == "true" || (flash[:checked_description].nil? && user.is_published_description == true)
      @checked_description = "checked"
    end
    if flash[:checked_url] == "true" || (flash[:checked_url].nil? && user.is_published_url == true)
      @checked_url = "checked"
    end
    if flash[:checked_twitter_url] == "true" || (flash[:checked_twitter_url].nil? && user.is_published_twitter_url == true)
      @checked_twitter_url = "checked"
    end
    if flash[:checked_record] == "true" || (flash[:checked_record].nil? && user.is_published_record == true)
      @checked_record = "checked"
    end
  end

  def profile_update
    user = @current_user
    name = params[:name]
    description = params[:description]
    url = params[:url]

    is_genuine = "true"

    if name == ""
      is_genuine = nil
      flash[:name_warning] = "ユーザー名を入力してください"
    elsif User.where.not(id: user.id).find_by(name: name)
      is_genuine = nil
      flash[:name] = nil
      flash[:name_warning] = "そのユーザー名は既に使用されています"
    else
      flash[:name] = name
    end

    if description.length > 300
      is_genuine = nil
      flash[:description] = nil
      flash[:description_warning] = "300字以内で記述してください"
    else
      flash[:description] = description
    end

    flash[:url] = url

    flash[:checked_profile] = params[:is_published_profile].nil? ? "false" : "true"
    flash[:checked_description] = params[:is_published_description].nil? ? "false" : "true"
    flash[:checked_url] = params[:is_published_url].nil? ? "false" : "true"
    flash[:checked_twitter_url] = params[:is_published_twitter_url].nil? ? "false" : "true"
    flash[:checked_record] = params[:is_published_record].nil? ? "false" : "true"

    if is_genuine
      if params[:is_default]
        user.remove_image!
        user.twitter_image = nil
      elsif params[:image].present?
        user.image = params[:image]
        user.twitter_image = nil
      end

      user.name = name
      user.description = description
      user.url = url

      user.is_published_profile = !params[:is_published_profile].nil?
      user.is_published_description = !params[:is_published_description].nil?
      user.is_published_url = !params[:is_published_url].nil?
      user.is_published_twitter_url = !params[:is_published_twitter_url].nil?
      user.is_published_record = !params[:is_published_record].nil?

      if user.save
        redirect_to("/settings/profile/done")
      else
        flash[:notice] = "プロフィールの更新に失敗しました"
        redirect_to("/settings/profile")
      end
    else
      redirect_to("/settings/profile")
    end
  end

  def profile_done
  end

  def password_form
  end

  def password_update
    user = @current_user
    current_password = params[:current_password]
    new_password = params[:new_password]
    new_password_confirmation = params[:new_password_confirmation]
    is_genuine = "true"

    if user.authenticate(current_password)
      flash[:current_password] = current_password
    else
      is_genuine = nil
      flash[:current_password_warning] = "パスワードが正しくありません"
    end

    if new_password.length < 8 || new_password.length > 32
      is_genuine = nil
      flash[:new_password_warning] = "8字以上、32字以下のパスワードを入力してください"
    else
      flash[:new_password] = new_password
    end

    if new_password != new_password_confirmation
      is_genuine = nil
      flash[:new_password_confirmation_warning] = "確認用のパスワードが一致しません"
    else
      flash[:new_password_confirmation] = new_password_confirmation
    end


    if is_genuine
      user.password = new_password
      user.password_confirmation = new_password_confirmation
      if user.save
        redirect_to("/settings/password/done")
      else
        flash[:notice] = "パスワードの更新に失敗しました"
        redirect_to("/settings/password")
      end
    else
      redirect_to("/settings/password")
    end
  end

  def password_done
  end

  def email_form
  end

  def email_update
    user = @current_user
    current_email = params[:current_email]
    new_email = params[:new_email]

    is_genuine = "true"

    if current_email != user.email
      is_genuine = nil
      flash[:current_email_warning] = "メールアドレスが間違っています"
    else
      flash[:current_email] = current_email
    end

    if new_email == ""
      is_genuine = nil
      flash[:new_email_warning] = "メールアドレスを入力してください"
    elsif User.where.not(id: user.id).find_by(email: new_email)
      is_genuine = nil
      flash[:new_email_warning] = "そのメールアドレスは既に使用されています"
    else
      flash[:new_email] = new_email
    end

    if is_genuine
      user.email = new_email
      if user.save
        redirect_to("/settings/email/done")
      else
        flash[:notice] = "メールアドレスの更新に失敗しました"
        redirect_to("/settings/email")
      end
    else
      redirect_to("/settings/email")
    end
  end

  def email_done
  end

  def email_create
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    is_genuine = "true"

    if email == ""
      is_genuine = nil
      flash[:email_warning] = "メールアドレスを入力してください"
    elsif User.find_by(email: email)
      is_genuine = nil
      flash[:email_warning] = "そのメールアドレスは既に使用されています"
    else
      flash[:email] = email
    end

    if password.length < 8 || password.length > 32
      is_genuine = nil
      flash[:password_warning] = "8字以上、32字以下のパスワードを入力してください"
    else
      flash[:password] = password
    end

    if password != password_confirmation
      is_genuine = nil
      flash[:password_confirmation_warning] = "確認用のパスワードが一致しません"
    else
      flash[:password_confirmation] = password_confirmation
    end

    if is_genuine
      user = @current_user
      user.email = email
      user.password = password
      user.password_confirmation = password_confirmation
      if user.save
        redirect_to("/settings/email/create-done")
      else
        flash[:notice] = "メールアドレスおよびパスワードの登録に失敗しました"
        redirect_to("/settings/email")
      end
    else
      redirect_to("/settings/email")
    end

  end

  def email_create_done
  end


  def sns_form
  end

  def sns_done
    case params[:code]
    when "connect-twitter"
      @message = "Twitterアカウントと連携しました。"
    when "disconnect-twitter"
      @message = "Twitter連携を解除しました。"
    else
      @message = nil
    end
  end

  def records_form
    user = @current_user

    @infinite_blocks_record = InfiniteBlocksRecord.find_by(user_id: user.id)
    @infinite_blocks_yearly_record = InfiniteBlocksYearlyRecord.where("updated_at >= ?", Date.today.prev_year(1)).find_by(user_id: user.id)
    @infinite_blocks_monthly_record = InfiniteBlocksMonthlyRecord.where("updated_at >= ?", Date.today.prev_month(1)).find_by(user_id: user.id)
    @infinite_blocks_weekly_record = InfiniteBlocksWeeklyRecord.where("updated_at >= ?", Date.today.prev_day(7)).find_by(user_id: user.id)
  end

  def records_done
    case params[:code]
    when "delete-infinite-blocks"
      @title = "レコード削除完了"
      @message = "『Infinite Blocks』のレコードを削除しました。"
    else
      @title = nil
      @message = nil
    end
  end

  def forgot_password_form
  end

  def forgot_password
    user = User.find_by(email: params[:email])
    token = generate_contemporary_password(24)

    if user
      while User.find_by(reset_password_token: token)
        token = generate_contemporary_password(24)
      end
      user.reset_password_token = token

      if user.save
        ResetPasswordMailer.send_text(user).deliver
        redirect_to("/login/forgot-password/done")
      else
        flash[:notice] = "確認用メールの送信に失敗しました"
        redirect_to("/login/forgot-password")
      end
    else
      flash[:email_warning] = "メールアドレスが正しくありません"
      redirect_to("/login/forgot-password")
    end
    
  end

  def forgot_password_done
  end

  def reset_password_form
    user = User.find_by(reset_password_token: params[:token])
    unless user
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

  def reset_password
    user = User.find_by(reset_password_token: params[:token])
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    is_genuine = "true"

    if user
      if password.length < 8 || password.length > 32
        is_genuine = nil
        flash[:password_warning] = "8字以上、32字以下のパスワードを入力してください"
      else
        flash[:password] = password
      end

      if password != password_confirmation
        is_genuine = nil
        flash[:password_confirmation_warning] = "確認用のパスワードが一致しません"
      else
        flash[:password_confirmation] = password_confirmation
      end

      if is_genuine
        user.password = password
        user.password_confirmation = password_confirmation
        user.reset_password_token = nil

        if user.save
          session[:user_id] = user.id
          redirect_to("/reset-password/done")
        else
          flash[:notice] = "パスワードの再設定に失敗しました"
          redirect_to("/")
        end
      else
        redirect_to("/reset-password/#{params[:token]}")
      end
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

  def reset_password_done
  end

  def twitter
    auth_hash = request.env["omniauth.auth"]
    @provider = auth_hash[:provider]
    @uid = auth_hash[:uid]
    @name = auth_hash[:info][:name]
    @image = auth_hash[:info][:image].sub(/_normal./,".")
    @description = auth_hash[:info][:description]
    @url = auth_hash[:info][:urls][:Website]
    @twitter_url = auth_hash[:info][:urls][:Twitter]
  end

  def twitter_post
    if params[:provider] == "twitter"
      twitter_user = User.find_by(twitter_uid: params[:uid])
      if twitter_user
        if session[:user_id]
          puts "Twitter Connection Error"
          flash[:twitter_connection_error] = "そのTwitterアカウントは既に使用されています"
          redirect_to("/settings/sns")
        else
          puts "Twitter Login"
          session[:user_id] = twitter_user.id
          redirect_to("/")
        end
      else
        if session[:user_id]
          puts "Twitter Connection"
          current_user = User.find_by(id: session[:user_id])
          current_user.twitter_uid = params[:uid]
          current_user.twitter_url = params[:twitter_url]
          if current_user.save
            redirect_to("/settings/sns/done/connect-twitter")
          else
            flash[:notice] = "Twitterとの連携に失敗しました"
            redirect_to("/settings/sns")
          end
        else
          puts "Twitter Signup"
          password = generate_contemporary_password(30)
          new_user = User.new(
            name: params[:name], 
            password: password, 
            password_confirmation: password, 
            twitter_uid: params[:uid], 
            twitter_url: params[:twitter_url], 
            twitter_image: params[:image],
            description: params[:description], 
            url: params[:url],
            is_published_profile: true,
            is_published_description: true,
            is_published_url: true,
            is_published_twitter_url: true,
            is_published_record: true,
          )

          index = 1
          while User.find_by(name: new_user.name)
            name = new_user.name
            index += 1
            new_user.name = "#{name}(#{index})"
          end

          if new_user.save
            session[:user_id] = User.find_by(twitter_uid: params[:uid]).id
            redirect_to("/signup/done")
          else
            flash[:notice] = "Twitterでの新規登録に失敗しました"
            redirect_to("/signup")
          end
        end
      end
    else
      flash[:notice] = "Twitter認証に失敗しました"
      redirect_to("/")
    end

  end

  def twitter_disconnect
    user = @current_user
    if user.email
      user.twitter_uid = nil
      user.twitter_url = nil
      if user.save
        redirect_to("/settings/sns/done/disconnect-twitter")
      else
        flash[:notice] = "Twitter連携解除に失敗しました"
        redirect_to("/settings/sns")
      end
    else
      flash[:notice] = "このアカウントにはメールアドレスが登録されていません"
      redirect_to("/settings/sns")
    end
  end

  def sns_failure
    if session[:user_id]
      flash[:notice] = "SNS連携に失敗しました"
      redirect_to("/settings/sns")
    else
      flash[:notice] = "ログインおよび新規登録に失敗しました"
      redirect_to("/")
    end
  end

  def delete_records_infinite_blocks
    user = @current_user
    record = InfiniteBlocksRecord.find_by(user_id: user.id)
    yearly_record = InfiniteBlocksYearlyRecord.find_by(user_id: user.id)
    monthly_record = InfiniteBlocksMonthlyRecord.find_by(user_id: user.id)
    weekly_record = InfiniteBlocksWeeklyRecord.find_by(user_id: user.id)

    record.destroy if record
    yearly_record.destroy if yearly_record
    monthly_record.destroy if monthly_record
    weekly_record.destroy if weekly_record

    redirect_to("/settings/records/done/delete-infinite-blocks")
  end

  private

  def generate_contemporary_password(num)
    retval = ""
    for i in 1..num
      code = rand(36).to_s(36)
      retval += code
    end
    return retval
  end
end
