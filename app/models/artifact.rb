require 'elasticsearch/model'

class Artifact < ActiveRecord::Base

	include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks

  	  # Analyze and map elasticsearch

  settings index: { number_of_shards: 1 } do
  mappings dynamic: 'false' do
    indexes :title, analyzer: 'english', index_options: 'offsets'
    indexes :content, analyzer: 'english'
  end
end

	belongs_to :user
	belongs_to :fellowship
	acts_as_taggable
	acts_as_votable

	def self.search(query)
		#where("content like ?", "%#{query}%")
		  __elasticsearch__.search(
    {
      query: {
        multi_match: {
          query: query,
          fields: ['title^10', 'content']
        }
      },
      highlight: {
        pre_tags: ['<em>'],
        post_tags: ['</em>'],
        fields: {
          title: {},
          content: {}
        }
      }
    }
  )

	end

	# change url
	def to_param
		"#{id} #{title}".parameterize
	end

=begin
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
=end
end

# Delete the previous Artifacts index in Elasticsearch
Artifact.__elasticsearch__.client.indices.delete index: Artifact.index_name rescue nil
 
# Create the new index with the new mapping
Artifact.__elasticsearch__.client.indices.create \
  index: Artifact.index_name,
  body: { settings: Artifact.settings.to_hash, mappings: Artifact.mappings.to_hash }


Artifact.import # Auto synching with elastic search

