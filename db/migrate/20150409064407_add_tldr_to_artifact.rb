class AddTldrToArtifact < ActiveRecord::Migration
  def change
    add_column :artifacts, :tldr, :string
  end
end
