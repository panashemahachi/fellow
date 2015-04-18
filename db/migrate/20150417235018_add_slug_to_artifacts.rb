class AddSlugToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :slug, :string
    add_index :artifacts, :slug
  end
end
