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
  def link_member_if_needed
    return unless user_signed_in? && current_user.member.nil?
    if (m = Member.find_by(email: current_user.email, user_id: nil))
      m.update!(user: current_user)
      flash.now[:notice] = "会員情報をアカウントにひも付けました。"
    end
  end

  before_action :link_member_if_needed

  def link_member_if_needed
    return unless user_signed_in? && current_user.member.nil?
    Member.where(user_id: nil).where('LOWER(email) = ?', current_user.email.downcase)
          .update_all(user_id: current_user.id)
  end
end
