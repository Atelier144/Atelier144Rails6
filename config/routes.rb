Rails.application.routes.draw do

  root "home#top"

  get "/games", to: "home#games"
  get "/apps", to: "home#apps"
  get "/news", to: "home#news"
  get "/terms", to: "home#terms"
  get "/privacy", to: "home#privacy"
  get "/contact", to: "home#contact_form"
  get "/contact/done", to: "home#contact_done"
  post "/contact", to: "home#contact"

  get "/profiles/:id", to: "users#profile"

  get "/signup", to: "users#signup_form"
  get "/signup/done", to: "users#signup_done"
  get "/login" , to: "users#login_form"
  post "/signup", to: "users#signup"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout"

  get "/login/forgot-password", to: "users#forgot_password_form"
  get "/login/forgot-password/done", to: "users#forgot_password_done"
  post "/login/forgot-password", to: "users#forgot_password"

  get "/reset-password/done", to: "users#reset_password_done"
  get "/reset-password/:token", to: "users#reset_password_form"
  post "/reset-password/:token", to: "users#reset_password"

  get "/auth/twitter/callback", to: "users#twitter"
  get "/auth/failure", to: "users#sns_failure"
  post "/twitter", to: "users#twitter_post"

  get "/settings/profile", to: "users#profile_form"
  get "/settings/profile/done", to: "users#profile_done"
  get "/settings/password", to: "users#password_form"
  get "/settings/password/done", to: "users#password_done"
  get "/settings/email", to: "users#email_form"
  get "/settings/email/done", to: "users#email_done"
  get "/settings/email/create-done", to: "users#email_create_done"
  get "/settings/sns", to: "users#sns_form"
  get "/settings/sns/done/:code", to: "users#sns_done"
  get "/settings/records", to: "users#records_form"
  get "/settings/records/done/:code", to: "users#records_done"

  post "/settings/profile", to: "users#profile_update"
  post "/settings/password", to: "users#password_update"
  post "/settings/email", to: "users#email_update"
  post "/settings/email/create", to: "users#email_create"

  post "/settings/sns/disconnect-twitter", to: "users#twitter_disconnect"

  post "/settings/records/delete/infinite-blocks", to: "users#delete_records_infinite_blocks"

  get "/games/infinite-blocks", to: "infinite_blocks#home"
  get "/games/infinite-blocks/result", to: "infinite_blocks#result"
  get "/games/infinite-blocks/records", to: "infinite_blocks#records"
  get "/games/infinite-blocks/records/:type", to: "infinite_blocks#records"

  post "/games/infinite-blocks/result/tweet", to: "infinite_blocks#tweet"
  get "/games/infinite-blocks/result/tweet-done", to: "infinite_blocks#tweet_done"

  post "/games/infinite-blocks/record", to: "infinite_blocks#record"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
