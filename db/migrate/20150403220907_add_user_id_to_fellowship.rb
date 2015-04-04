class AddUserIdToFellowship < ActiveRecord::Migration
  def change
  	add_column :fellowships, :user_id, :integer
  end
end
