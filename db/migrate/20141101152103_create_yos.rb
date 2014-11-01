class CreateYos < ActiveRecord::Migration
  def change
    create_table :yos do |t|
      t.string :username

      t.timestamps
    end
  end
end
