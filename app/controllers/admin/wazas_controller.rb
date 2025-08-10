class Admin::WazasController < Admin::BaseController
  before_action :set_waza, only: [:edit, :update, :destroy]

  def index
    @wazas = Waza.includes(:rank, :video)
                 .order("ranks.display_order ASC, wazas.order_in_rank ASC")
  end

  def new
    @waza = Waza.new
    @waza.build_video
  end

  def create
    @waza = Waza.new(waza_params)
    if @waza.save
      redirect_to admin_wazas_path, notice: "技を登録しました。"
    else
      @waza.build_video if @waza.video.nil?
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @waza.build_video if @waza.video.nil?
  end

  def update
    if @waza.update(waza_params)
      redirect_to admin_wazas_path, notice: "技を更新しました。"
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
    @waza = Waza.find(params[:id])
  end

  def waza_params
    params.require(:waza).permit(
      :rank_id, :shinsa_set, :koumoku, :content, :order_in_rank,
      video_attributes: [:id, :title, :url, :platform, :description, :_destroy]
    )
  end
end
