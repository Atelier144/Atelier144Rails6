class ContactMailer < ApplicationMailer
    default from: Rails.application.credentials.email[:email]

    def send_text(email, title, content)
        @email = email
        @title = title
        @content = content
        mail(subject: "『Atelier144』へのお問い合わせ", to: Rails.application.credentials.admin_email[:email]) do |format|
            format.text
        end
    end
end
