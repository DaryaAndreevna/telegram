class Handlers::CallbackHandler

  attr_reader :chat_id, :target, :user

  def initialize response, user
    @chat_id  = response.message.chat.id
    @target   = response.data
    @user     = user

    Actions::CloseCallback.new(response.id).call
  end

  def call
    case target

    # when 'show_mine'
      # Callbacks::ScheduleFlowCallback.new(user).call(:taken)

    when /^select_time_([0-9]+)/
      Callbacks::SelectAppointmentCallback.new(user).call($LAST_MATCH_INFO[1])

    when /^decline_time_([0-9]+)/
      Callbacks::DeclineAppointmentCallback.new(user).call($LAST_MATCH_INFO[1])

    when /^schedule/
      by_group  = target.match(/by_group_([0-9]+)/).try(:[], 1)
      by_place  = target.match(/by_place_([0-9]+)/).try(:[], 1)
      by_date   = target.match(/by_date_([0-9\-]+)/).try(:[], 1)

      Callbacks::ScheduleFlowCallback.new(user).call(by_group, by_place, by_date)

    when /^records/
      by_group  = target.match(/by_group_([0-9]+)/).try(:[], 1)
    
      Callbacks::UserRecordsCallback.new(user).call(by_group)

    else
    end
  end
end
