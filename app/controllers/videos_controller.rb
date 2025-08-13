class VideosController < ApplicationController

 def index
    @shinsa_keys = Waza.shinsa_sets.keys
    @ranks = if Rank.column_names.include?("position")
               Rank.order(:position)
             else
               Rank.order(:id)
             end

    @videos = Video
                .includes(waza: :rank) # 表示時のN+1を抑止
                .by_shinsa_set(params[:shinsa_set])
                .by_rank(params[:rank_id])
                .order(created_at: :desc)
  end

  def show
    @video = Video.find(params[:id])
  end
end
