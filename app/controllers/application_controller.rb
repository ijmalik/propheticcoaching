class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # before_filter :configure_permitted_parameters
  # before_filter :configure_permitted_parameters, if: :registration_controller?

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    # P "app con====================================="
    # redirect_to user_path(current_user), :alert => exception.message
    redirect_to user_path(current_user), :notice => exception.message
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless (current_user && current_user.has_role?(:admin))
  end

  def current_permission
    @current_permission ||= ::Permissions.permission_for(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth]
    # devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth, :remember_me]
    # devise_parameter_sanitizer.for(:sign_up) << :username
    # p "====devise================"
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth) }
    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth) }
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth) }
   end

  private

  #def after_sign_in_path_for(resource)
  #  PrivatePub.publish_to("/chats/talk", :message => {message: "#{current_user.name} entered.", user_name: ""}.to_json)
  #  current_user.is_admin? ? root_path : coach_path(current_user.id)
  #end
  #
  #def after_sign_out_path_for(resource_or_scope)
  #  PrivatePub.publish_to("/chats/talk", :message => {message: "#{current_user.name} left.", user_name: ""}.to_json)
  #  new_user_session_path
  #end

end
