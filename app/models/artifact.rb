class Artifact < ActiveRecord::Base
	belongs_to :user
	belongs_to :fellowship
	acts_as_taggable
	acts_as_votable

	def self.search(query)
		where("content like ?", "%#{query}%")
	end
end
