class MembersController < ApplicationController
  before_action :authenticate_user!

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
  def member_params
    params.require(:member).permit(:name, :phone_number, :gender, :birthday, :address,
      :enroll_on, :next_exam_on, :privacy_policy_agreed, :rank_id)
  end
end
