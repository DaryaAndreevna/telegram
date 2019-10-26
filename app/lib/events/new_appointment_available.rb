class Events::NewAppointmentAvailable

  attr_reader :appointment

  def initialize(appointment)
    @appointment  = appointment
  end

  def call
    return unless relevant?
    Actions::Broadcast.new.call(chat_ids, message)
  end

  private

  def message
    "Доступно новое время для записи \n #{formatted_time} \n #{appointment.place.name}"
  end

  def formatted_time
    I18n.l(appointment.time, format: "%e %B %a %H:%M")
  end

  def chat_ids
    appointment.squads_users.pluck(:chat_id).compact
  end

  def relevant?
    Appointment.future.current_week.exists?(appointment.id)
  end
end
