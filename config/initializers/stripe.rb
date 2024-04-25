Rails.application.credentials.dig(:sripe, :publishable_key)
Rails.application.credentials.dig(:sripe, :secret_key)

Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
