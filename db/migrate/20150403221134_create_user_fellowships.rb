class CreateUserFellowships < ActiveRecord::Migration
  def change
    create_table :user_fellowships do |t|

      t.timestamps null: false
    end
  end
end
