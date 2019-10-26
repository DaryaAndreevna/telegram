class User < ApplicationRecord
  has_many :users_appointments, dependent: :destroy
  has_many :appointments, through: :users_appointments
  has_many :users_squads, dependent: :destroy
  has_many :squads, through: :users_squads, after_add: :joined_squad_notification

  accepts_nested_attributes_for :squads

  def squad_names
    squads.pluck(:name).join(', ')
  end

  def joined_squad_notification(squad)
    Events::JoinedSquadNotification.new(self, squad).call
  end
end
