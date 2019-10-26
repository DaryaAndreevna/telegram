class Callbacks::UserRecordsCallback < Callbacks::Base

  attr_reader :squad

  def call(group_id = nil)
    @squad = Squad.find_by(id: group_id) || user_has_one_group

    !squad ? request_group : user_records
  end

  private

  def request_group
    return empty_notification if user.squads.empty?

    markup = Markups::Collections::SquadsRenderer.new(user.squads, type: :records)
    message = "Выберите группу"
    Actions::Message.new(markup).call(user.chat_id, message)
  end

  def user_records
    return empty_notification if appointments.empty?

    markup = Markups::Collections::UserRecordsRenderer.new(appointments)
    message = "Нажми, чтобы отменить"
    Actions::Message.new(markup).call(user.chat_id, message)
  end

  def user_has_one_group
    return nil if user.squads.count > 1
    
    user.squads.first
  end

  def empty_notification
    message = "Нет данных"
    Actions::Message.new.call(user.chat_id, message)
  end

  def appointments
    @appointments ||= squad.appointments.actual.joins(:users).where("users.id = ?", user.id)
  end
end
