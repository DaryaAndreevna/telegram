class Actions::Broadcast < Actions::Base
  
  attr_reader :renderer

  def initialize(renderer = Markups::DefaultRenderer.new)
    @renderer = renderer
  end

  def call(chat_ids, text)
    bot.send_broadcast(chat_ids, text, markup: renderer.markup)
  end
end
