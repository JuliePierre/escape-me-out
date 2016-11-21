class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :nb_players, presence: true, numericality: { only_integer: true }
  validates :starts_at, presence: true
  validates :duration, presence: true
end
