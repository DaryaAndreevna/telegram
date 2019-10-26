require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context "Scope" do

		days 	= %w(Mon Tue Wed Thu Fri Sat Sun)
  	from 	= Date.parse('2019-05-06 13:00')
  	to 		= Date.parse('2019-05-21 13:00')

  	timerange = (from...to).to_a

  	let(:place) { Place.create }
  	let(:appointments) {
			timerange.each do |time|
    		Appointment.create(place: place, time: time)
  		end

  		Appointment.all
  	}

  	timerange.each_with_index do |date, index|
  		it "for #{days[date.wday - 1]}" do

  			appointments

	    	today = date
	    	Date.stub(:today).and_return(today)

	    	actual = Appointment.actual
	    	future = Appointment.future
	    	weekly = Appointment.current_week
	    	current = Appointment.future.current_week

	    	p "First Week"
	    	p "#{days[date.wday - 1]} Schedule"
	    	p "Actual #{actual.map{|a| [a.time.to_date.day, days[a.time.to_date.wday - 1]].join(' ')}.join(', ')}"
	    	p "Future #{future.map{|a| [a.time.to_date.day, days[a.time.to_date.wday - 1]].join(' ')}.join(', ')}"
	    	p "Current #{current.map{|a| [a.time.to_date.day, days[a.time.to_date.wday - 1]].join(' ')}.join(', ')}"
	      
	      (expect(actual.first.time).to eq today) 					if actual.any?
	      (expect(future.first.time).to eq today + 1.day) 	if future.any?
	      (expect(weekly.last.time).to eq today.next_week) 	unless timerange.last == date
	      expect(Appointment.future.current_week.count).to eq (7 - index%7) unless timerange.last == date

	    end
    end
  end
end
