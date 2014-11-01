class AddColumnToIncomings < ActiveRecord::Migration
  def change
  	add_column :incomings, :text, :string
  end
end
