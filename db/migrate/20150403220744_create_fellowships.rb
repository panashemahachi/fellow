class CreateFellowships < ActiveRecord::Migration
  def change
    create_table :fellowships do |t|

      t.timestamps null: false
    end
  end
end
