class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :games
  has_many :bookings

  def host?
    Game.find_by(user_id: id)
  end

  def host_game?(game)
    self.games.include?(game)
  end

  def player?
    Booking.find_by(user_id: id)
  end
end
