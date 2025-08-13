class Admin::WazasController < Admin::BaseController
  before_action :set_waza, only: [:edit, :update, :destroy]

  def index
    @ranks       = Rank.order(:id) # position があれば :position
    @shinsa_keys = Waza.shinsa_sets.keys

    @wazas = Waza.includes(:rank, :videos).order(:rank_id, :order_in_rank)
    @wazas = @wazas.by_rank(params[:rank_id])
    @wazas = @wazas.by_shinsa_set(params[:shinsa_set])
  end

  def new
    @waza = Waza.new
  end

def create
  @waza = Waza.new(waza_params)
  if @waza.save
    redirect_to admin_wazas_path, notice: "作成しました"
  else
    @waza.videos.build unless @waza.videos.any?(&:new_record?)
    render :new, status: :unprocessable_entity
  end
end

  def edit
  end

  def update
    if @waza.update(waza_params)
      redirect_to admin_wazas_path, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @waza.destroy
    redirect_to admin_wazas_path, notice: "技を削除しました。"
  end

  private
  def set_waza
    @waza = Waza.includes(videos: :rank).find(params[:id])
  end

def waza_params
  params.require(:waza).permit(
    :rank_id, :order_in_rank, :shinsa_set, :koumoku,
    :content, :description,
    videos_attributes: [:id, :title, :url, :platform, :description, :rank_id, :_destroy]
  )
  end
end
