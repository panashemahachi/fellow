class UserFellowship < ActiveRecord::Base
	belongs_to :user
	belongs_to :fellowship
end
