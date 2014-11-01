class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.integer :population
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
