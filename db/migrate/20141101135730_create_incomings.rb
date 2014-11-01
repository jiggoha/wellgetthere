class CreateIncomings < ActiveRecord::Migration
  def change
    create_table :incomings do |t|

      t.timestamps
    end
  end
end
