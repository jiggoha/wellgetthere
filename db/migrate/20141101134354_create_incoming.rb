class CreateIncoming < ActiveRecord::Migration
  def change
    create_table :incomings do |t|
      t.string :text

      t.timestamps
    end
  end
end
