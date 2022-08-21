class AddTotalFeeToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :total_fee, :string
  end
end
