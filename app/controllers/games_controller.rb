class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    @game = Game.find(params[:id])
    @booking = Booking.new
    @date = get_date
  end

  private

  def get_date
    Date.today
  end
end
