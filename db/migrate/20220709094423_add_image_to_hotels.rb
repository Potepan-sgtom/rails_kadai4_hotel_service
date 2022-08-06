class AddImageToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :image, :string
  end
end
