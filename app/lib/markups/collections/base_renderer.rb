class Markups::Collections::BaseRenderer

	def markup
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
  end

  def buttons
  	raise
  end
end
