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

  def recover_params
    @user = User.first
    @nb_players = 5
    @starts_at = Time.now
    @duration = 1

  end
end
