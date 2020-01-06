class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
