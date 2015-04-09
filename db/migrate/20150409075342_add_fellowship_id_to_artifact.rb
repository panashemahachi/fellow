class AddFellowshipIdToArtifact < ActiveRecord::Migration
  def change
  	add_column :artifacts, :fellowship_id, :integer
  end
end
