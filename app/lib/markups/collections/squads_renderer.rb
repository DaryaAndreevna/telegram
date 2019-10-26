class Markups::Collections::SquadsRenderer < Markups::Collections::BaseRenderer

	attr_reader :squads, :options

  def initialize(squads, options = {})
  	@options = options
  	@squads = squads
  end

  def buttons
    squads.map do |squad|
      Markups::Items::SquadRenderer.new(squad, options).button
    end
  end
end
