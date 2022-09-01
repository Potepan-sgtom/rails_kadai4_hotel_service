class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.integer :user_id
      t.string :area
      t.string :name

      t.timestamps
    end
  end
end
