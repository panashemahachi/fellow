class AddPublicToFellowship < ActiveRecord::Migration
  def change
    add_column :fellowships, :public_fellowship, :boolean
  end
end
