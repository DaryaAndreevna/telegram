namespace :notifications do
  desc "Send notifications to users"
  task send_schedule: :environment do
  	return unless Time.now.wday == 1 ### Monday only

    User.find_each do |user|
    	Callbacks::ShowScheduleCallback.new(user).call(:all)
    end
  end
end
