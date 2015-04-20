json.array!(@countries) do |country|
  json.extract! country, :id, :name, :flag
  json.url country_url(country, format: :json)
end
