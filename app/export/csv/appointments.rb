class Csv::Appointments
	attr_reader :scope

	def initialize(scope)
		@scope = scope
	end

	def generate
		csv_file
	end

	private

	def csv_file
		CSV.generate(headers: false) do |csv|
      by_group(scope).each do |group|

        csv << empty_row
        csv << empty_row
        csv << ["Группа\n#{group.group_name}"]
        csv << empty_row
        csv << ["Дата", "Время", "Место", "Участники" ]

        group_appointments  = Appointment.where(id: group.ids)

        by_day(group_appointments).each do |day|

          day_appointments  = group_appointments.where(id: day.ids).includes(:users, :place)
          date = I18n.l(day.s_time, format: "%e %B %a")

          csv << [ date, "", "", "" ]

          day_appointments.each do |a|

            time  = I18n.l(a.time, format: "%H:%M")
            place = a.place.name
            users = a.users.pluck(:name).join("\n")

            csv << [ "", time, place, users ]
          end
        end
      end
    end
	end

	def empty_row
		Array.new(5)
	end

  def by_group records
    records.joins(:squads).group("group_name")
      .select("squads.name as group_name, array_agg(appointments.id) as ids")
  end

  def by_day records
    records.group("s_time").reorder("s_time")
      .select("date(appointments.time) as s_time, array_agg(appointments.id) as ids")
  end
end
