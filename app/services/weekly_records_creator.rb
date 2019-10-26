class WeeklyRecordsCreator
	DAYS = [:tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
	TIMES = ['12:00', '14:00', '16:00', '18:00']

	attr_accessor :place_id, :squad_ids

	def call(place_id, squad_ids)
		@place_id = place_id
		@squad_ids = squad_ids

		raise if !place_id || squad_ids.empty?

		build
	end

	def start_date
		Date.today.last_week.next_week(DAYS.first).to_s
	end

	def end_date
		Date.today.last_week.next_week(DAYS.last).to_s
	end

	private

	def build
		DAYS.each do |day|
			date = Date.today.last_week.next_week(day)
			day_schedule(date)
		end
	end

	def day_schedule(date)
		TIMES.each do |time|
			date_time = DateTime.parse("#{date.to_s} #{time}")
			Appointment.create(time: date_time, place_id: place_id, squad_ids: squad_ids)
		end
	end
end
