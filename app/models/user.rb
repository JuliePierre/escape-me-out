class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :games
  has_many :bookings

  def host?
    if Game.find_by(user_id: id)
      return true
    else
      return false
    end
  end

  def host_game?(game)
    self.games.include?(game)
  end

  def player?
    if Booking.find_by(user_id: id)
      return true
    else
      return false
    end
  end
end
