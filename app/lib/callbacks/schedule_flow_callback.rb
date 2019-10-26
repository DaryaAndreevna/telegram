class Callbacks::ScheduleFlowCallback < Callbacks::Base

  attr_reader :group, :place, :date

  def call(group_id = nil, place_id = nil, date = nil)

    @group = Squad.find_by(id: group_id) || user_has_one_group
    @place = Place.find_by(id: place_id)
    @date  = date

    case
    when group.nil?    then request_group      and return
    when scope.empty?  then empty_notification and return
    when place.nil?    then request_place      and return
    when date.nil?     then request_date       and return
    else
      request_time
    end

  end

  private

  def user_has_one_group
    return nil if user.squads.count > 1
    
    user.squads.first
  end

  def empty_notification
    message = 'Нет данных'
    Actions::Message.new.call(user.chat_id, message)
  end

  def no_group_message
    message = 'Ожидайте добавления в группу'
    Actions::Message.new.call(user.chat_id, message)
  end

  def request_group
    return no_group_message if user.squads.empty?

    markup = Markups::Collections::SquadsRenderer.new(user.squads)
    message = "Выберите группу"
    Actions::Message.new(markup).call(user.chat_id, message)
  end

  def request_place
    callback_prefix = "by_group_#{group.id}_"
    markup = Markups::Collections::PlacesRenderer.new(scope, callback_prefix)
    message = "Выберите площадку"
    Actions::Message.new(markup).call(user.chat_id, message)
  end

  def request_date
    callback_prefix = "by_group_#{group.id}_by_place_#{place.id}_"
    markup = Markups::Collections::DaysRenderer.new(scope, callback_prefix)
    message = "Выберите день"
    Actions::Message.new(markup).call(user.chat_id, message)
  end

  def request_time
    markup = Markups::Collections::TimesRenderer.new(scope)
    message = "#{date} #{place.name}\n Нажми, чтобы записаться"
    Actions::Message.new(markup).call(user.chat_id, message)
  end

  def appointments
    @appointments ||= Appointment.future.current_week
  end

  def scope
    by_date by_place by_group appointments
  end

  def by_group scope
    return scope unless group

    scope.joins(:squads).where("squads.id = ?", group.id)
  end

  def by_place scope
    return scope unless place

    scope.where(place_id: place.id)
  end

  def by_date scope
    return scope unless date

    scope.where("DATE(appointments.time) = ?", date)
  end
end
