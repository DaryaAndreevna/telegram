class UsersAppointment < ApplicationRecord
  belongs_to  :user
  belongs_to  :appointment, counter_cache: :user_count

  validates_uniqueness_of :user_id, scope: :appointment_id
end
