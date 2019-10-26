### Needed for stop spinner run

class Actions::CloseCallback < Actions::Base

  attr_reader :query_id

  def initialize(query_id)
    @query_id = query_id
  end

  def call
    bot.answer_callback_query(query_id)
  end
end
