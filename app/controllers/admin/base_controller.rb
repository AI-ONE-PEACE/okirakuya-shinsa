# app/controllers/admin/base_controller.rb
before_action :authenticate_user!
before_action :require_admin!
private
def require_admin!
  redirect_to(root_path, alert: "権限がありません") unless current_user&.admin?
end
