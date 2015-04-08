class Fellowshipment < ActiveRecord::Base
	belongs_to :fellowship
	belongs_to :user
end
