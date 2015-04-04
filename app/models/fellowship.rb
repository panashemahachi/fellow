class Fellowship < ActiveRecord::Base
	has_many :fellowships
	has_many :users, :through => :user_fellowships
end
