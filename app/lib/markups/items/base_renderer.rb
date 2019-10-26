class Markups::Items::BaseRenderer

	def markup
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [ button ])
  end

  def button
    Telegram::Bot::Types::InlineKeyboardButton.new(text: text, callback_data: callback)
  end

  private

  def text
  	raise
  end

  def callback
  	raise
  end
end
