class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :hotel_id
      t.integer :member
      t.integer :price
      t.datetime :checkin
      t.datetime :checkout

      t.timestamps
    end
  end
end
