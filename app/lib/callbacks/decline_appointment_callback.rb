class Callbacks::DeclineAppointmentCallback < Callbacks::Base

  attr_reader :appointment

  ANSWERS = {
    done: "Отменено!",
    error: "Не получилось :(",
    too_late: "Невозможно отменить"
  }

  def call(appointment_id)
    @appointment = Appointment.find_by(id: appointment_id)

    Actions::Message.new(markup).call(user.chat_id, message)
  end

  private

  def markup
    Markups::DefaultRenderer.new
  end

  def message
    ANSWERS[status] || ANSWERS[:error]
  end

  def status
    ::DeclineService.new(appointment, user).call
  end
end
