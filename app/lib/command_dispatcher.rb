class CommandDispatcher

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def dispatch(response)
    case response

    when Telegram::Bot::Types::CallbackQuery
      Handlers::CallbackHandler.new(response, user).call

    when Telegram::Bot::Types::Message
      Handlers::MessageHandler.new(response, user).call
    end
  end
end
