class AddPriceToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :price, :integer
  end
end
