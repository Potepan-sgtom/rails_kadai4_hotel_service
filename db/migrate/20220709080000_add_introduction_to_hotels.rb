class AddIntroductionToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :introduction, :text
  end
end
