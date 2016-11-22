class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :pick_current_game, only: [:new]


  def new
    recover_params
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(new_booking_params)
    @booking.save
    redirect_to booking_path(@booking)
  end

  private

  def pick_current_game
    @game = Game.find(params[:game_id])
  end

  def new_booking_params
    params.require(:booking).permit(:game_id, :user_id, :nb_players, :starts_at, :duration)
  end

  def params_from_show
    params.permit(:nb_players, :time_select, :duration, :date )
  end

  def recover_params
    @user = current_user
    @nb_players = params_from_show[:nb_players].to_i
    @duration = params_from_show[:duration].to_i

    hour = params_from_show[:time_select]
    date = params_from_show[:date]

    @starts_at = DateTime.parse("#{date} #{hour}")
  end

end
