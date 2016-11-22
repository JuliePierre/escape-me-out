class GamesController < ApplicationController

skip_before_action :authenticate_user!, only: [:index, :show]
before_action :find_game, only: [:show, :edit, :update]

  def index
    params[:search] = nil if params[:search] == ""
    params[:nb_players] = nil if params[:nb_players] == ""

    if params[:search] == nil && params[:nb_players] == nil
      @games = Game.all
    elsif params[:search] == nil && params[:nb_players] != nil
      @games = Game.where("min_players <= ? AND max_players >= ?", params[:nb_players], params[:nb_players])
    elsif params[:search] != nil && params[:nb_players] == nil
      @games = Game.where("name LIKE ? OR address LIKE ?", params[:search], "%#{params[:search]}%")
    elsif params[:search] != nil && params[:nb_players] != nil
      @games = Game.where("min_players <= ? AND max_players >= ?", params[:nb_players], params[:nb_players]).where("name LIKE ? OR address LIKE ?", params[:search], "%#{params[:search]}%")
    else
      @games = Game.all
    end

   @date = params[:date]
   # permettra de filter les escape games selon dispo à cette date là
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save!
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def show
    @booking = Booking.new
    @date = get_date
    @availabilities = @game.availabilities(@date).map { |x| x.strftime("%H:%M") }
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :photo)
  end

  def game_params
    params.require(:game).permit(:name, :description, :address, :phone_number, :min_players, :max_players, :price_per_hour)
  end

  def get_date
    # To be modified to parse params[:date]
    Date.parse("2016-11-21")
  end
end
