class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :countries_id
      t.string :name
      t.string :image

      t.timestamps null: false
    end
  end
end
