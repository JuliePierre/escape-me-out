class ChangeDateFormatInBookings < ActiveRecord::Migration[5.0]
  def change
    change_column :bookings, :starts_at, :datetime
  end
end
