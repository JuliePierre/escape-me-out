class UsersController < ApplicationController
  before_action :find_user_id, only: [:show, :edit, :update]

  def show
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

# The show must render depending on the type of account:
#   a. if customer: booked games
#   b. if host: list of games listed on the marketplace

# what can the user edit?
# 1. Avatar
# 2. Name: first name and last name
# 3. Address
# 4. Phone number
# 5. email
# 6. password
