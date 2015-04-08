class AddFellowshipNameToFellowship < ActiveRecord::Migration
  def change
    add_column :fellowships, :fellowship_name, :string
  end
end
