class BookingsController < ApplicationController
  before_action :pick_current_game, only: [:new]


  def new
    formating_date
    @booking = Booking.new
  end

  def update
    pending_booking = Booking.find(params[:booking_id])
    if params[:do] == "accept"
      pending_booking.update(accepted: true)
      pending_booking = nil
    elsif params[:do] == "decline"
      pending_booking.update(accepted: false)
      pending_booking = nil
    end
    redirect_to user_path(params[:id])
  end

  def create
    @booking = Booking.new(new_booking_params)
    # binding.pry
    @booking.starts_at -= 1.hour
    @booking.save
    redirect_to user_path(current_user)
  end

  private

  def pick_current_game
    @game = Game.find(params[:game_id])
  end

  def new_booking_params
    params.require(:booking).permit(:game_id, :user_id, :nb_players, :starts_at, :duration)
  end

  def formating_date
    hour = params[:time_select]
    date = params[:date]
    @starts_at = DateTime.parse("#{date} #{hour}")
  end

end
