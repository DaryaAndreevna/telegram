ActiveAdmin.register Squad do
  permit_params :name, :weekly_records_limit, :active

  show do
    attributes_table do
      row :active
      row :name
      row :weekly_records_limit
      row('Users') { |squad| squad.user_names }
    end
  end
end
