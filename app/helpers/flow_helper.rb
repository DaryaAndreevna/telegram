module FlowHelper
  include StringsHelper
  def self.get_text_for_start_command(user)
    case user.state
    when 0
      StringsHelper::HELLO_MESSAGE
    when 1
      StringsHelper::NICE_TO_MEET_YOU
    when 2
      StringsHelper::WELCOME_BACK_AGAIN + user.name
    end
  end
end
