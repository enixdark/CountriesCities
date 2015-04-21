class City < ActiveRecord::Base
	belongs_to :country
	mount_uploader :image, ImageCityUploader
	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
