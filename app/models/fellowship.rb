class Fellowship < ActiveRecord::Base
	has_many :fellowshipments
	has_many :users, :through => :fellowshipments
	has_many :artifacts
	
	# change url
	def to_param
		"#{id} #{fellowship_name}".parameterize
	end
end
