# app/controllers/ranks_controller.rb
class RanksController < ApplicationController
#  skip_before_action :authenticate_user!, only: [:index], raise: false

  def index
    @ranks = Rank.includes(:members).order(:id)
  end
end
