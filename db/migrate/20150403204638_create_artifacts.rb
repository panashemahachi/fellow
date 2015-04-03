class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string :title
      t.string :kind
      t.string :content

      t.timestamps null: false
    end
  end
end
