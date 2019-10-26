class Markups::Items::TimeRenderer

  attr_reader :appointment

  def initialize(appointment)
    @appointment = appointment
  end

  def markup
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [ button ])
  end

  def button
    Telegram::Bot::Types::InlineKeyboardButton.new(text: text, callback_data: callback)
  end

  private

  def text
    label = "#{formatted_time}"
    label += " (#{vacant} мест)" unless unlimited?

    label
  end

  def callback
    "select_time_#{appointment.id}"
  end

  def formatted_time
    I18n.l(appointment.time, format: "%H:%M")
  end

  def vacant
    vp = appointment.vacant_places 

    vp.zero? ? 'нет' : vp
  end

  def unlimited?
  	appointment.attendee_limit.nil?
  end
end
