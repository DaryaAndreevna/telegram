class Events::JoinedSquadNotification

  attr_reader :user, :squad

  def initialize(user, squad)
    @user   = user
    @squad  = squad
  end

  def call
    message = "Вас добавили в группу\n#{squad.name}"
    Actions::Message.new.call(user.chat_id, message)
  end
end
