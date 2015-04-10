class Artifact < ActiveRecord::Base
	belongs_to :user
	belongs_to :fellowship
	acts_as_taggable
	acts_as_votable

	def self.search(query)
		where("content like ?", "%#{query}%")
	end

	# return artifacts user liked
	def self.liked_artifacts
		arr = []
		Artifact.all.each do |a|
			if current_user.voted_up_on? a
				arr << a
			end
		end

		return arr
	end
end
