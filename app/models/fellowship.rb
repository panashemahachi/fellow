class Fellowship < ActiveRecord::Base
	has_many :fellowshipments
	has_many :users, :through => :fellowshipments
	has_many :artifacts
end
