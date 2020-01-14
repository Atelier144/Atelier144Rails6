class HomeController < ApplicationController
  def top
    @news = News.order(created_at: :desc).limit(5)
  end

  def games
  end

  def apps
  end

  def news
    @news = News.order(created_at: :desc)
  end

  def terms
  end

  def privacy
  end

  def contact_form
    if @current_user
      @email = @current_user.email
    end
  end

  def contact
    email = params[:email]
    title = params[:title]
    content = params[:content]
    is_genuine = "true"

    if email == ""
      is_genuine = nil
      flash[:email_warning] = "メールアドレスを入力してください"
    end

    if title == ""
      is_genuine = nil
      flash[:title_warning] = "件名を入力してください"
    else
      flash[:title] = title
    end

    if content == ""
      is_genuine = nil
      flash[:content_warning] = "メッセージ内容を入力してください"
    else
      flash[:content] = content
    end

    if is_genuine
      ContactMailer.send_text(email, title, content).deliver
      redirect_to("/contact/done")
    else
      redirect_to("/contact")
    end
  end

  def contact_done
  end
end
