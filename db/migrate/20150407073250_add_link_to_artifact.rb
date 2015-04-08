class AddLinkToArtifact < ActiveRecord::Migration
  def change
    add_column :artifacts, :link, :string
  end
end
