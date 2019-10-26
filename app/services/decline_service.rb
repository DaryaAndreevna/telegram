class DeclineService

  HOUR_OF_END_OF_DAY = 19
  STATUS = [:done, :error, :too_late]

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

    check_in ? :done : :error
  end

  def check_in
    appointment.decline_user(user)
  end

  def too_late?
    appointment.time.to_date == Date.today || 
    (
      appointment.time.to_date == Date.tomorrow &&
      Time.now.hour >= HOUR_OF_END_OF_DAY && 
      Time.now.min > 0
    )
  end
end
