class Markups::Items::UserRecordRenderer < Markups::Items::BaseRenderer

  attr_reader :appointment

  def initialize(appointment)
    @appointment  = appointment
  end

  private

  def text
    "#{time} (#{appointment.place.name})"
  end

  def callback
    "decline_time_#{appointment.id}"
  end

  def time
    I18n.l(appointment.time, format: "%e %B %a %H:%M")
  end
end
