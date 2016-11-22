class Game < ApplicationRecord
  DEFAULT_STARTS_TIME = [18, 19, 20]

  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :min_players, presence: true, numericality: { only_integer: true }
  validates :max_players, presence: true, numericality: { only_integer: true }
  validates :price_per_hour, presence: true

  has_attachment :photo

  def availabilities(date)
    # Returns an array of available start time for the given date


    # Returns false if no availability on given date
  end
end
