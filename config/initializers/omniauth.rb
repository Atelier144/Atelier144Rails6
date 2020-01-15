Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter,
    "key",
    "secret_key"
end

OmniAuth.config.on_failure = Proc.new {|env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure}
