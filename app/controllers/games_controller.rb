class GamesController < ApplicationController

skip_before_action :authenticate_user!, only: [:index, :show]
before_action :find_game, only: [:show, :edit, :update, :destroy]

  def index
    params[:address] = nil if params[:address] == ""
    params[:nb_players] = nil if params[:nb_players] == ""
    params[:name] = nil if params[:name] == ""

    if params[:address] == nil && params[:nb_players] == nil && params[:name] == nil
      @games = Game.all
    elsif params[:address] == nil && params[:nb_players] == nil && params[:name] != nil
      @games = Game.where("name ILIKE ?", "%#{params[:name]}")
    elsif params[:address] == nil && params[:nb_players] != nil && params[:name] == nil
      @games = Game.where("min_players <= ? AND max_players >= ?", params[:nb_players], params[:nb_players])
    elsif params[:address] != nil && params[:nb_players] == nil && params[:name] == nil
      @games = Game.near(params[:address], 20)
    elsif params[:address] != nil && params[:nb_players] != nil && params[:name] == nil
      @games = Game.near(params[:address], 20).where("min_players <= ? AND max_players >= ?", params[:nb_players], params[:nb_players])
    else
      @games = Game.all
    end


    @games_co = @games.where.not(latitude: nil)

    @games_coordinates = Gmaps4rails.build_markers(@games) do |game, marker|
      marker.lat game.latitude
      marker.lng game.longitude
      marker.infowindow "<a href='#{game_path(game)}'> #{game.name} </a><p>From #{game.min_players} to #{game.max_players} players</p>"
    end


    # @games_coordinates = @games_co.map do |game|
    #   { lat: game.latitude, lng: game.longitude }
    # end

    @date = params[:date]

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

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :description, :address, :phone_number, :min_players, :max_players, :price_per_hour, :photo)
  end

  def get_date
    # To be modified to parse params[:date]
    Date.parse("2016-11-21")
  end
end
