class Actions::Message < Actions::Base

  attr_reader :renderer

  def initialize(renderer = Markups::DefaultRenderer.new)
    @renderer = renderer
  end

  def call(chat_id, text)
    bot.send_message(chat_id, text, markup: renderer.markup)
  end
end
