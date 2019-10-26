class Markups::Items::PlaceRenderer < Markups::Items::BaseRenderer

  attr_reader :place, :callback_prefix

  def initialize(place, callback_prefix = nil)
    @place = place
    @callback_prefix = callback_prefix
  end

  private

  def text
    "#{place.name}"
  end

  def callback
    "schedule_" + callback_prefix.to_s + "by_place_#{place.id}"
  end
end
