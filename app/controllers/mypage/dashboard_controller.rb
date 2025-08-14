class Mypage::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :load_member

  def index
    @current_rank  = @member&.rank
    @last_exam_on  = @member&.last_exam_on
    @next_exam_on  = @member&.next_exam_on

    @current_wazas =
      if @current_rank
        Waza.includes(:videos).where(rank_id: @current_rank.id).order(:order_in_rank).to_a
      else
        []
      end

     @next_rank =
      if @current_rank
        if Rank.column_names.include?('position') && @current_rank.position.present?
          Rank.where('position > ?', @current_rank.position).order(:position).first ||
            Rank.where('id > ?', @current_rank.id).order(:id).first
        else
          Rank.where('id > ?', @current_rank.id).order(:id).first
        end
      end

      @next_wazas =
      if @next_rank
        Waza.includes(:videos).where(rank_id: @next_rank.id).order(:order_in_rank).to_a
      else
        []
      end
  end

  private

  def load_member
    if current_user.admin? && params[:member_id].present?
      @member = Member.find_by(id: params[:member_id])
      redirect_to root_path, alert: '会員が見つかりません' and return unless @member
    else
      @member = current_user.member
      redirect_to root_path, alert: '会員情報がありません' and return unless @member
    end
  end
end
