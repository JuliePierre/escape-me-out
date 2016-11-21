class Game < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :min_players, presence: true, numericality: { only_integer: true }
  validates :max_players, presence: true, numericality: { only_integer: true }
  validates :price_per_hour, presence: true
end
