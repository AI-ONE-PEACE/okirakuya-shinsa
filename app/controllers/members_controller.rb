# app/controllers/members_controller.rb
class MembersController < ApplicationController
  before_action :authenticate_user!                 # 認証必須
  before_action :require_admin!, only: [:new, :create] # 作成は管理者のみ

  def index
    @members = Member.includes(:rank).order(created_at: :desc)
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to members_path, notice: "会員を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def require_admin!
    return if current_user&.admin?
    redirect_to(root_path, alert: "権限がありません") # URL直打ち対策
  end

  def member_params
    params.require(:member).permit(
      :name, :phone_number, :gender, :birthday, :address,
      :enroll_on, :next_exam_on, :privacy_policy_agreed, :rank_id
    )
  end
end
