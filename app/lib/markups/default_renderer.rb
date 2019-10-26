class Markups::DefaultRenderer

  def markup
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons, resize_keyboard: true)
  end

  def buttons
    [ show_all_button, show_mine_button ]
  end

  private

  def show_all_button
    Telegram::Bot::Types::KeyboardButton.new(text: 'Расписание')
  end

  def show_mine_button
    Telegram::Bot::Types::KeyboardButton.new(text: 'Мои записи')
  end

end
