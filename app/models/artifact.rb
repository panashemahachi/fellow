class Artifact < ActiveRecord::Base
	belongs_to :user
	acts_as_taggable
	acts_as_votable

	def self.search(query)
		where("title like ?", "%#{query}%")
	end
end
