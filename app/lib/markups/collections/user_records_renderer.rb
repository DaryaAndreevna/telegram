class Markups::Collections::UserRecordsRenderer < Markups::Collections::BaseRenderer

  attr_reader :scope

  def initialize(scope = Appointment.actual)
    @scope = scope
  end

  def buttons
    scope.map do |appointment|
      Markups::Items::UserRecordRenderer.new(appointment).button
    end
  end
end
