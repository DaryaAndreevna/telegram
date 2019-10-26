class Actions::SetWebhook < Actions::Base

  def call
    bot.set_webhook
  end
end
