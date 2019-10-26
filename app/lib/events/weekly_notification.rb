class Events::WeeklyNotification

  def call
    chat_ids = User.all.pluck(:chat_id)
    message = "Доступно новое расписание"
    Actions::Broadcast.new.call(chat_ids, message)
  end
end
