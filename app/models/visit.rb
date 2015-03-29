class Visit < ActiveRecord::Base
	belongs_to :url, dependent: :destroy, counter_cache: true
end
