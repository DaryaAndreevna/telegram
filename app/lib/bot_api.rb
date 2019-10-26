require 'telegram/bot'

class BotApi

  SERVICE_URL    = "https://api.telegram.org"
  HOST           = Rails.application.credentials.host       || ENV["CALLBACK_HOST"]
  BOT_NUMBER     = Rails.application.credentials.bot_number || ENV["BOT_NUMBER"]
  TOKEN          = Rails.application.credentials.bot_token  || ENV["BOT_TOKEN"]
  CALLBACK_URL   = "webhooks/telegram_lXQnaR2oyMmE01thbCsMzyVI9KWYZNxgbHKFWmXZyDiQnwnj12msitOc8yUfuaZK"

  def send_message(chat_id, text, markup: nil)
    return unless chat_id

    api.call('sendMessage', chat_id: chat_id, text: text, reply_markup: markup)

  rescue Telegram::Bot::Exceptions::ResponseError => e
    Rails.logger.error(e.message)
  end

  def send_broadcast(chat_ids, text, markup: nil)
    # api.call('sendBroadcast', chat_ids: chat_ids, text: text, reply_markup: markup) :(((

    chat_ids.each do |chat_id|
      send_message(chat_id, text, markup: markup)
    end
  end

  def answer_callback_query(id)
    api.call('answerCallbackQuery', callback_query_id: id)
  end

  def set_webhook
    api.call('setWebhook', url: set_webhook_url)
  end

  private

  def api
    @api ||= ::Telegram::Bot::Api.new(TOKEN)
  end

  def set_webhook_url
    [SERVICE_URL, "/", BOT_NUMBER, "/", 'setWebhook?url=', HOST, "/", CALLBACK_URL].join
  end
end
