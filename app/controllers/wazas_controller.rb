class WazasController < ApplicationController
  def index
    @ranks       = Rank.order(:id) # position があれば :position
    @shinsa_keys = Waza.shinsa_sets.keys

    @wazas = Waza.includes(:rank, :videos).order(:rank_id, :order_in_rank)
    @wazas = @wazas.by_rank(params[:rank_id])
    @wazas = @wazas.by_shinsa_set(params[:shinsa_set])
  end

  def show
    @waza = Waza.includes(:rank, :video).find(params[:id])
  end
end
