ActiveAdmin.register User do
  permit_params :name, :role, squad_ids: []

  index do
    column :name
    column("Squads") { |user| user.squad_names }
    actions
  end

  form do |f|
    f.inputs "User Data" do
      f.input :name
    end
    f.inputs "Squads" do
      f.input :squads, as: :select, collection: Squad.active.map{|s| [s.name, s.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row('Suqads') { |user| user.squad_names }
    end
  end

end
