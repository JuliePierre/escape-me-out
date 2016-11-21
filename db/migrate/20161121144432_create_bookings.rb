class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.integer :nb_players
      t.date :starts_at
      t.integer :duration
      t.boolean :accepted

      t.timestamps
    end
  end
end
