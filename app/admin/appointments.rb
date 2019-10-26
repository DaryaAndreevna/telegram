ActiveAdmin.register Appointment do
  config.sort_order = 'time_desc'

  permit_params :time, :attendee_limit, :place_id, squad_ids: []

  filter :time
  filter :users
  filter :squads
  filter :place

  includes :squads, :place, :users

  index do
    selectable_column
    column :time
    column :attendee_limit
    column :place

    column("Squads") { |app| app.squads.pluck(:name).join(", ") }

    column("Attendees") { |appointment| appointment.attendee_names }

    actions
  end

  form do |f|
  	f.inputs "Place" do
  		f.input :place, as: :select, collection: Place.all.map{|s| [s.name, s.id] }
  	end
  	f.inputs "Time" do
  		f.input :time
  	end
  	f.inputs "Attendee Limit" do
  		f.input :attendee_limit
  	end
    f.inputs "Squads" do
      f.input :squads, as: :select, collection: Squad.active.map{|s| [s.name, s.id] }
    end

    f.actions
  end

  collection_action :import_csv, method: :get do

    records = Appointment.ransack(params[:q]).result(distinct: true)
    csv = Csv::Appointments.new(records).generate

    send_data csv.encode('utf-8'), type: 'text/csv; charset=utf-8; header=present', disposition: "attachment; filename=schedule_report.csv"
  end

  collection_action :notify, method: :get do
    Events::WeeklyNotification.new.call
    redirect_to admin_appointments_path, method: :get
  end

  collection_action :create_collection, method: :post do
    permitted = params.require(:weekly_collection).permit(:place_id, squad_ids: [])

    creator = WeeklyRecordsCreator.new
    creator.call(permitted[:place_id], permitted[:squad_ids])

    redirect_to admin_appointments_path(q: { 
      time_gteq_datetime: creator.start_date, 
      time_lteq_datetime: creator.end_date
    }), method: :get
  end

  collection_action :new_collection, method: :get do
  end

  if Date.today.monday?
    action_item :add do
      link_to "Create weekly records", new_collection_admin_appointments_path(q: params[:q].try(:permit!)), method: :get
    end
  end

  action_item :add do
    link_to "Export to CSV", import_csv_admin_appointments_path(q: params[:q].try(:permit!)), method: :get
  end

  action_item :add do
    link_to "Notify Users", notify_admin_appointments_path(q: params[:q].try(:permit!)), method: :get
  end
end
