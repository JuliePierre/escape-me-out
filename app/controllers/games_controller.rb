class GamesController < ApplicationController

skip_before_action :authenticate_user!, only: [:index, :show, :get_available_time_slots, :get_possible_durations]
before_action :find_game, only: [:show, :edit, :update, :destroy]

  def index
    params[:search] = nil if params[:search] == ""
    params[:nb_players] = nil if params[:nb_players] == ""

    if params[:search] == nil && params[:nb_players] == nil
      @games = Game.all
    elsif params[:search] == nil && params[:nb_players] != nil
      @games = Game.where("min_players <= ? AND max_players >= ?", params[:nb_players], params[:nb_players])
    elsif params[:search] != nil && params[:nb_players] == nil
      @games = Game.where("name ILIKE ? OR address ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    elsif params[:search] != nil && params[:nb_players] != nil
      @games = Game.where("min_players <= ? AND max_players >= ?", params[:nb_players], params[:nb_players]).where("name ILIKE ? OR address ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @games = Game.all
    end
    @games = @games.where.not(latitude: nil)
    @games_coordinates = @games.map do |game|
      { lat: game.latitude, lng: game.longitude }
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
    if @game.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def show
    @booking = Booking.new
    @date = get_date
    @availabilities = @game.availabilities(@date).map { |x| x.strftime("%H:%M") }

    @game_coordinates = [{ lat: @game.latitude, lng: @game.longitude }]
  end

  def edit
  end

  def destroy
    @game.destroy
    redirect_to user_path(current_user)
  end

  def update
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render :edit
    end
  end

  def get_available_time_slots
    my_date = Date.parse(params[:date])
    my_game = Game.find(params[:id]).availabilities(my_date)
    render :json => my_game
  end

  def get_possible_durations
    my_date = Date.parse(params[:date])
    my_time = Time.parse(params[:time])
    my_game = Game.find(params[:id])
    dt = DateTime.new(my_date.year, my_date.month, my_date.day, my_time.hour, my_time.min, my_time.sec, my_time.zone)
    render :json => my_game.possible_durations(dt)
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :description, :address, :phone_number, :min_players, :max_players, :price_per_hour, :photo)
  end

  def get_date
    params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
