class AddDefaultImageToUser < ActiveRecord::Migration
  def change
  	  add_column :users, :default_pic, :string, :default => "http://pkm.me/noprofile.png"
  end
end
