class Markups::Collections::PlacesRenderer < Markups::Collections::BaseRenderer

	attr_reader :places, :scope, :callback_prefix

  def initialize(scope = Appointment.actual, callback_prefix = nil)
  	@callback_prefix = callback_prefix
    @scope = scope
  end

  def buttons
    places.map do |place|
      Markups::Items::PlaceRenderer.new(place, callback_prefix).button
    end
  end

  private

  def places
  	@places ||= scope.joins(:place).group("places.id").select("places.*").reorder("")
  end
end
