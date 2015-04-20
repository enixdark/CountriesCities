class CreateData 
	def self.execute filepath
		text = File.open(filepath,"rb:UTF-16LE").read
		data = eval text
		data.each do |countries, cities|
			c = Country.create!(name: countries,flag: :nil)
			cities.each do |city|
				City.create!(country_id: c.id,name: city,image: :nil)
			end
		end
	end
end