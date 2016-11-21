class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :description
      t.string :address
      t.string :phone_number
      t.integer :min_players
      t.integer :max_players
      t.integer :price_per_hour

      t.timestamps
    end
  end
end
