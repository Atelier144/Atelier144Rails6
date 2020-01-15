ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    domain: "gmail.com",
    port: 587,
    user_name: "gameatelier144@gmail.com",
    password: "e7s12TPIN43Enfp",
    authentication: "plain",
    enable_starttls_auto: true
}
