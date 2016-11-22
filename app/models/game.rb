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

  def availabilities(my_date)
    # Returns an array of available start time for the given date
    bookings_for_this_game_and_date = Booking.where('game_id = ? AND DATE(starts_at) = ?', id, my_date)

    possible_start_time = DEFAULT_STARTS_TIME.map { |hour_integer| self.class.hour_to_datetime(hour_integer, my_date) }

    available_start_times = possible_start_time.select do |start_time|
      start_time_authorized = true
      bookings_for_this_game_and_date.each do |booking|
        if start_time.between?(booking.starts_at, booking.starts_at + booking.duration.hour)
          start_time_authorized = false
        end
      end
      start_time_authorized
    end

    # Returns false if no availability on given date
    available_start_times.empty? ? false : available_start_times
  end

  private

  def self.hour_to_datetime(my_hour, my_date)
    string_hour = my_hour.to_s.length == 1 ? "0" + my_hour.to_s : my_hour.to_s
    string_date_time = my_date.to_s + " " + string_hour + ":00:00 +0100"
    DateTime.parse(string_date_time)
  end
end
