require 'telegram/bot'

class WebhooksController < ApplicationController
  include CommandsHelper
  include FlowHelper

  #lXQnaR2oyMmE01thbCsMzyVI9KWYZNxgbHKFWmXZyDiQnwnj12msitOc8yUfuaZK
  #https://api.telegram.org/bot790912268:AAHVlAP1-MjqV_HIY4XJL0zlvwk62Mfunq4/setWebhook?url=https://4150e15b.ngrok.io/webhooks/telegram_lXQnaR2oyMmE01thbCsMzyVI9KWYZNxgbHKFWmXZyDiQnwnj12msitOc8yUfuaZK
  #https://api.telegram.org/bot790912268:AAHVlAP1-MjqV_HIY4XJL0zlvwk62Mfunq4/setWebhook?url=http://6cebf961.ngrok.io/webhooks/telegram_lXQnaR2oyMmE01thbCsMzyVI9KWYZNxgbHKFWmXZyDiQnwnj12msitOc8yUfuaZK

  # GET /users
  # GET /users.json
  def index

  end

  def telegram_lXQnaR2oyMmE01thbCsMzyVI9KWYZNxgbHKFWmXZyDiQnwnj12msitOc8yUfuaZK
    CommandDispatcher.new(user).dispatch(message_params)
    head :ok
  end

  private

  def webhook_params
    params.require(:webhook)
  end

  def message_params
    parsed = ::Telegram::Bot::Types::Update.new(params.permit!)
    parsed.message || parsed.callback_query
  end

  def from
    message_params.from.id
  end

  def user
    @user ||= User.find_or_create_by(telegram_id: from)
  end
end
