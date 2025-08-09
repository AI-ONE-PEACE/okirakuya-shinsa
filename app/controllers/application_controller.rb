# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  private
  def after_sign_in_path_for(resource)
    path = stored_location_for(resource)
    if path&.start_with?("/admin") && !resource.admin?
      return root_path
    end
    resource.admin? ? admin_root_path : root_path
  end
end
