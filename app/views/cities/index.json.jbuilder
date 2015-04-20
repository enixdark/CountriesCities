json.array!(@cities) do |city|
  json.extract! city, :id, :countries_id, :name, :image
  json.url city_url(city, format: :json)
end