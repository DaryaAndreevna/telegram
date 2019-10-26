class Handlers::MessageHandler
  include CommandsHelper

  attr_reader :chat_id, :text, :user

  def initialize response, user
    @chat_id  = response.chat.id
    @text     = response.text
    @user     = user
  end

  def call
    case text
    when START
      greeting

    when 'Расписание'
      Callbacks::ScheduleFlowCallback.new(user).call

    when 'Мои записи'
      Callbacks::UserRecordsCallback.new(user).call

    else
      set_user_name
    end
  end

  private


  def greeting
    user.update(chat_id: chat_id)

    user.name.present? ? greeting_message : ask_to_provide_name_message
  end

  def set_user_name
    return error_message if user.name.present? 

    user.update(name: text)
    new_name_has_been_set_message
  end

  def error_message
    nil
    # Actions::Message.new.call(chat_id, "Ты ебанулся или шо?")
  end

  def new_name_has_been_set_message
    Actions::Message.new.call(chat_id, "Привет, #{user.name.titleize}")
  end

  def greeting_message
    Actions::Message.new.call(chat_id, "Привет, #{user.name.titleize}")
  end

  def ask_to_provide_name_message
    Actions::Message.new(::Markups::BlankRenderer.new).call(chat_id, FlowHelper::get_text_for_start_command(user))
  end
end
