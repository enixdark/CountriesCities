# require_relative '../uploaders/flag_uploader'

class Country < ActiveRecord::Base
	has_many :cities, -> { select 'cities.*' }
	mount_uploader :flag, FlagUploader 
	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
