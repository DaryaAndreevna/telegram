class Markups::Items::SquadRenderer < Markups::Items::BaseRenderer

  attr_reader :squad, :type

  TYPES = [:schedule, :records]

  def initialize(squad, type: :schedule)
    @squad = squad
    @type = type
  end

  private

  def text
    "#{squad.name}"
  end

  def callback
    "#{type}_" + "by_group_#{squad.id}"
  end
end
