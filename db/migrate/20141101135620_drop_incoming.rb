class DropIncoming < ActiveRecord::Migration
  def change
  	drop_table :incomings
  end
end
