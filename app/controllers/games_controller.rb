class GamesController < ApplicationController
skip_before_action :authenticate_user!, only: :index
  def index
    if params[:search] != ""
      if params[:players] != ""
        @games = Game.where("min_players <= ? AND max_players >= ?", params[:players], params[:players]).where("name LIKE ? OR address LIKE ?", params[:search], "%#{params[:search]}%")
      else
        @games = Game.where("name LIKE ? OR address LIKE ?", params[:search], "%#{params[:search]}%")
      end
    elsif params[:players] != ""
      @games = Game.where("min_players <= ? AND max_players >= ?", params[:players], params[:players])
    else
      @games = Game.all
   end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    raise
    if @game.save!
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :description, :address, :phone_number, :min_players, :max_players, :price_per_hour)
  end
end
