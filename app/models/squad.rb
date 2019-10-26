class Squad < ApplicationRecord
  has_many :users_squads, dependent: :destroy
  has_many :users, through: :users_squads

  has_many :squads_appointments
  has_many :appointments, through: :squads_appointments

  scope :active, -> { where(active: true) }

  def user_names
    users.pluck(:name).join(', ')
  end
end
