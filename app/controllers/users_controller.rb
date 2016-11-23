class UsersController < ApplicationController
  before_action :find_user_id, only: [:show, :edit, :update]

  def show
    @games_customer = []
    bookings = Booking.where(user_id: @user.id)
    bookings.each { |book| @games_customer << Game.find(book.game_id) }
    @games_host = @user.games

    @host_bookings = Booking.joins(:game).where(games: { user_id: @user.id })
    @pending_bookings = @host_bookings.where(accepted: nil)

  end

  def edit
  end

  def update
    @user = User.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :phone_number)
  end

  def find_user_id
    @user = User.find(params[:id])
  end

end

################ COMMENT SECTION ################

# what can the user edit?
# 1. Avatar
# 2. Name: first name and last name
# 3. Phone number
# 4. password

#   <!-- Accept/Decline -->
# <% @pending_bookings.each do |booking| %>
#   <%= booking.game_id.name %>
# <% end  %>
