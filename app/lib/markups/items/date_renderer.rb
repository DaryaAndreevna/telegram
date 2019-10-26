class Markups::Items::DateRenderer < Markups::Items::BaseRenderer

  attr_reader :date, :appointments, :callback_prefix

  def initialize(date, appointment_ids, callback_prefix = nil)
  	@appointments = Appointment.where(id: appointment_ids)
  	@callback_prefix = callback_prefix
    @date = date
  end

  private

  def text
    label = "#{formatted_date}"
    label += " (#{vacant} мест)" unless unlimited?

    label
  end

  def callback
  	"schedule_" + callback_prefix.to_s + "by_date_#{date}"
  end

  def formatted_date
    I18n.l(date, format: "%e %B %a")
  end

  def vacant
  	vp = appointments.inject(0){|sum, ap| sum += ap.vacant_places}

    vp.zero? ? 'нет' : vp
  end

  def unlimited?
  	appointments.any?{|a| a.attendee_limit.nil? }
  end
end
