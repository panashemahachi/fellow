class AddDescriptionToFellowship < ActiveRecord::Migration
  def change
    add_column :fellowships, :fellowship_description, :string
  end
end
