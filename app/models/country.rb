class Country < ActiveRecord::Base
	has_many :cities, -> { select 'cities.*' }

	#, :through => :follows
end
