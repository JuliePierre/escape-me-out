class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :pick_current_game, only: :new


  def new
    recover_params
    @booking = Booking.new
  end

  def update
    pending_booking = Booking.find(params[:booking_id])
    if params[:action] == "accept"
      # if pending_booking.game.user.id == current_user_id
      pending_booking.accepted = true
      pending_booking.save
    elsif params[:action] == "decline"
      pending_booking.accepted = false
      pending_booking.save
    end
    redirect_to user_path(@current_user)
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
