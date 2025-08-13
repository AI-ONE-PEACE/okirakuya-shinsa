# app/controllers/mypage/dashboard_controller.rb
class Mypage::DashboardController < Mypage::BaseController
  def index
    @member = current_user.member

    return unless @member

    rank_scope = if Rank.column_names.include?("position")
                   Rank.order(:position)
                 else
                   Rank.order(:id)
                 end

    @current_rank = @member.rank
    @next_rank = if @current_rank
                   rank_scope.where("id > ?", @current_rank.id).first
                 else
                   nil
                 end

    @last_exam_on = @member.last_exam_on
    @next_exam_on = @member.next_exam_on

    @current_wazas = @current_rank ? Waza.includes(:videos).where(rank: @current_rank).order(:order_in_rank) : []
    @next_wazas    = @next_rank    ? Waza.includes(:videos).where(rank: @next_rank).order(:order_in_rank)    : []
  end
end
