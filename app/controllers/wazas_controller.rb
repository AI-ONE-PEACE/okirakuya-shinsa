class WazasController < ApplicationController
  def index
    @wazas = Waza.includes(:rank, :video)
                 .order("ranks.display_order ASC, wazas.order_in_rank ASC")
  end

  def show
    @waza = Waza.includes(:rank, :video).find(params[:id])
  end
end
