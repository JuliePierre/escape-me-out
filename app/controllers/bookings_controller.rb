class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :pick_current_game, only: :new


  def new
    recover_params
    @booking = Booking.new
  end

  def update
    pending_booking = Booking.find(params[:booking_id])
    if params[:do] == "accept"
      pending_booking.update(accepted: true)
    elsif params[:do] == "decline"
      pending_booking.update(accepted: false)
    end
    redirect_to user_path(current_user)
  end


  private

  def pick_current_game
    @game = Game.find(params[:game_id])
  end

  def recover_params
    @user = User.first
    @nb_players = 5
    @starts_at = Time.now
    @duration = 1

  end
end
