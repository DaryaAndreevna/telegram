class Appointment < ApplicationRecord
  has_many :users_appointments, dependent: :destroy
  has_many :users, through: :users_appointments

  has_many :squads_appointments, dependent: :destroy
  has_many :squads, through: :squads_appointments
  has_many :squads_users, through: :squads, source: :users

  belongs_to :place

  default_scope { order(time: :desc) }

  scope :actual, -> { where('date(time) >= ?', Date.today).order(:time) }
  scope :future, -> { where('date(time) > ?',  Date.today).order(:time) }
  scope :current_week, -> { where('time <= ?', Date.today.next_week).order(:time) }
  scope :incomplete, -> { where('user_count < attendee_limit') }

  # after_create :notify_users

  def check_in_user(user)
    users << user

  rescue ActiveRecord::RecordInvalid
    false
  end

  def decline_user(user)
    users.delete user
    Appointment.reset_counters(self.id, :users)

  rescue ActiveRecord::RecordInvalid
    false
  end

  def attendee_names
    users.pluck(:name).join(', ')
  end

  def incomplete?
    return true unless attendee_limit

    user_count < attendee_limit
  end

  def vacant_places
    attendee_limit - user_count
  end

  private

  # def notify_users
  #   Events::NewAppointmentAvailable.new(self).call
  # end
end
