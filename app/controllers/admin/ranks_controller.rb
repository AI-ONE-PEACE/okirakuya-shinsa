# app/controllers/admin/ranks_controller.rb
class Admin::RanksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @ranks = Rank.order(:position)
  end

  private
  def ensure_admin!
    redirect_to root_path, alert: "権限がありません" unless current_user&.admin?
  end
end
