class AddStateAndUserToIncomings < ActiveRecord::Migration
  def change
  	add_column :incomings, :state, :string
  	add_column :incomings, :user, :integer
  end
end
