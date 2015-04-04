class AddFellowshipIdToUser < ActiveRecord::Migration
  def change
  	add_column :users, :fellowship_id, :integer
  end
end
