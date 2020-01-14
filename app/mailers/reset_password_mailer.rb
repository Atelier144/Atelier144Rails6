class ResetPasswordMailer < ApplicationMailer
    default from: Rails.application.credentials.email[:email]

    def send_text(user)
        @user = user
        mail(subject: "パスワード再設定", to: @user.email) do |format|
            format.text
        end
    end
end
