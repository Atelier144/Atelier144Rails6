ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    domain: "gameatelier144.com",
    port: 587,
    user_name: Rails.application.credentials.email[:email],
    password: Rails.application.credentials.email[:password],
    authentication: "plain",
    enable_starttls_auto: true,
    openssl_verify_mode: "none"
}
