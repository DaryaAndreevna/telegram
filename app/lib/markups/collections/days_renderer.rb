class Markups::Collections::DaysRenderer < Markups::Collections::BaseRenderer

	attr_reader :days, :scope, :callback_prefix

  def initialize(scope = Appointment.actual, callback_prefix = nil)
  	@callback_prefix = callback_prefix
    @scope = scope
  end

  def buttons
    days.map do |date|
      Markups::Items::DateRenderer.new(date.date, date.appointments, callback_prefix).button
    end
  end

  private

  def days
  	@days ||= scope.group("DATE(appointments.time)")
  			 .select("DATE(appointments.time) as date, ARRAY_AGG(appointments.id) as appointments")
  			 .reorder("")
  end
end
