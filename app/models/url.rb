class Url < ActiveRecord::Base
	has_many :visits
	validates :link, presence: true, uniqueness: true, url: true

	default_scope { order(visits_count: :desc) }
	scope :find_by_slug,  -> (slug) { find(Encoder.decode(slug))}

	def slug
		Encoder.encode(id)
	end

end