class CheckInService

  HOUR_OF_END_OF_DAY = 19
  STATUS = [:done, :error, :too_late, :fullfilled, :had_registered_before, :week_limit]

  attr_reader :appointment, :user

  def initialize(appointment, user)
    @appointment  = appointment
    @user         = user
  end

  def call
    status
  end

  private

  def status
    return :too_late if too_late?
    return :fullfilled unless incomplete?
    return :had_registered_before if had_registered_before?
    return :week_limit if week_limit?

    check_in ? :done : :error
  end

  def check_in
    appointment.check_in_user(user)
  end

  def too_late?
    appointment.time.to_date == Date.tomorrow &&
    Time.now.hour >= HOUR_OF_END_OF_DAY && 
    Time.now.min > 0
  end

  def incomplete?
    appointment.incomplete?
  end

  def week_limit?
    @appointment.squads.all? do |group|
      limit = group.weekly_records_limit
      limit && user_appointments_current_week(group).count >= limit
    end
  end

  def had_registered_before?
    same_date_appointments = user_appointments
      .where("DATE(time) = ?", appointment.time.to_date)
      .where("squads.id in (?)", appointment.squad_ids)

    same_date_appointments.any?
  end

  def user_appointments
    Appointment.joins(:users)
      .where("users.id = ?", user.id)
      .joins(:squads)

  end

  def user_appointments_current_week(group)
    user_appointments
      .where("squads.id = ?", group.id)
      .where(
        "DATE(time) >= ? AND DATE(time) <= ?", 
        Time.now.at_beginning_of_week,
        Time.now.at_end_of_week,
      )
  end
end
