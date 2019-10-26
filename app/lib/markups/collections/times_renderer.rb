class Markups::Collections::TimesRenderer

	attr_reader :scope, :times

  def initialize(scope = Appointment.actual)
    @scope = scope
  end

  def markup
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
  end

  def buttons
    scope.map do |appointment|
      Markups::Items::TimeRenderer.new(appointment).button
    end
  end
end
