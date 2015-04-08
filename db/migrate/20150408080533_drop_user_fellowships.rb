class DropUserFellowships < ActiveRecord::Migration
  def change
  	drop_table :user_fellowships
  end
end
