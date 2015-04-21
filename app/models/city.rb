class City < ActiveRecord::Base
	belongs_to :country
	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
