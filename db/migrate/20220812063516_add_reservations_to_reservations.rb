class AddReservationsToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :reservations, :string
  end
end
