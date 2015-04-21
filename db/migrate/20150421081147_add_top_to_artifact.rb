class AddTopToArtifact < ActiveRecord::Migration
  def change
    add_column :artifacts, :top_artifact, :boolean, :default => false
  end
end
