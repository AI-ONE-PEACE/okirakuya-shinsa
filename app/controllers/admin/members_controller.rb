class Admin::MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_member, only: %i[show edit update destroy]

  def index
    @members = Member.order(created_at: :desc)
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to admin_member_path(@member), notice: "会員を登録しました。"
    else
      flash.now[:alert] = "登録に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def show;
    @member = Member.find(params[:id])
    @wazas  = @member.rank ? @member.rank.wazas.order(:order_in_rank) : Waza.none
  end

  def edit; end

  def update
    if @member.update(member_params)
      redirect_to admin_member_path(@member), notice: "更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
    redirect_to admin_members_path, notice: "削除しました。"
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  # ★DB列名に合わせる（いまのスキーマ準拠）
  def member_params
    params.require(:member).permit(
      :name, :kana, :email, :phone_number, :gender,
      :birthday, :enroll_on, :last_exam_on, :next_exam_on,
      :role, :rank_id, :address, :privacy_policy_agreed, :notes
    )
  end

  def require_admin!
    redirect_to root_path, alert: "権限がありません。" unless current_user&.admin?
  end
end
