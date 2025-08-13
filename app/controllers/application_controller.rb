# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
protected
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up,        keys: [:name])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name])
end

private
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || (resource.respond_to?(:admin?) && resource.admin? ? admin_root_path : mypage_root_path)
  end
end
