class AddLinkFaviconToArtifact < ActiveRecord::Migration
  def change
    add_column :artifacts, :link_favicon, :string
  end
end
