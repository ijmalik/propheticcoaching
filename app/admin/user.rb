ActiveAdmin.register User do
  #
  #permit_params :first_name, :last_name, :email, :address, :home_phone,
  #              :availablity_time, :best_time_to_call, :date_of_birth,
  #              :status, :role_ids => []
  actions :all, :except => [:new]


  controller do
    def permitted_params
      params.permit!
      #params.permit(:user => [:first_name, :last_name, :email, :address, :home_phone,
      #                        :availablity_time, :best_time_to_call, :date_of_birth,
      #                        :status, :role_ids => []])
    end
  end

  index do
    column :first_name
    column :last_name
    column :email
    column :address
    column :roles do |user|
      "#{user.roles_name.join(', ')}"
    end
    column :home_phone
    column :availablity_time
    column :status do |user|
      user.status? ? "Enabled" : "Disabled"
    end
    column :best_time_to_call
    column :date_of_birth
    #column :current_sign_in_at
    #column :last_sign_in_at
    #column :current_sign_in_ip
    #column :last_sign_in_ip
    default_actions
  end

  form do |f|
    f.inputs "details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      #f.input :roles, :as => :select, :collection => {"Admin" => :admin, "Coach" => :coach, "Mentee" => :mentee}
      f.input :roles, :as => :check_boxes
      f.input :home_phone
      f.input :availablity_time, :as => :select, :collection => {"Morning" => "morning", "Afternoon" => "afternoon", "Evening" => "evening"}
      f.input :status, :as => :select, :collection => {"Enable" => true, "Disable" => false}
      f.input :best_time_to_call
      f.input :date_of_birth
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :address
      row :roles do |user|
        "#{user.roles_name.join(', ')}"
      end
      row :home_phone
      row :availablity_time
      row :best_time_to_call
      row :date_of_birth
      row :mentees do |user|
        #user.mentees.collect{|r| {r.name => r.id}}.each{|name, id| link_to(name, admin_mentee_path(id))}
        #user.mentees.collect{ |r| link_to(r.name, admin_mentee_path(r.id)) }
        #user.mentees.collect{ |r| {r.name => r.id} }.each{ |hash| p link_to(hash.keys.first, admin_mentee_path(hash.values.first))}
        user.mentees.collect{ |r| link_to(r.name, admin_mentee_path(r.id)) }.join(", ").html_safe
      end
    end
    active_admin_comments
  end

end
