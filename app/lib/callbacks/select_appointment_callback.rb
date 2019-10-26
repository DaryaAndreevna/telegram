class Callbacks::SelectAppointmentCallback < Callbacks::Base

  attr_reader :appointment

  ANSWERS = {
    done: "Записано!",
    error: "Не получилось :(",
    too_late: "Запись невозможна",
    fullfilled: "Не осталось мест на это время",
    had_registered_before: "Вы уже записаны на эту дату",
    week_limit: "Превышен лимит записей в неделю"
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
    ::CheckInService.new(appointment, user).call
  end
end
