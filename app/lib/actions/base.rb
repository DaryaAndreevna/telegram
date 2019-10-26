class Actions::Base

  def bot(provider = BotApi)
    @bot ||= provider.new
  end
end
