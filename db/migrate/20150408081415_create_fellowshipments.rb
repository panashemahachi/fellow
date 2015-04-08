class CreateFellowshipments < ActiveRecord::Migration
  def change
    create_table :fellowshipments do |t|
      t.integer :user_id
      t.integer :fellowship_id
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
