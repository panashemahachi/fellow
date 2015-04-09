class AddSocialToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_link, :string, :default => ""
    add_column :users, :twitter_link, :string, :default => ""
    add_column :users, :linkedin_link, :string, :default => ""
  end
end
