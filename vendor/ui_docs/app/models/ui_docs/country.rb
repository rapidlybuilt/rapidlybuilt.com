# Copied from RapidUI | Source: rapid_ui/docs/app/models/country.rb
module UiDocs
  Country = Struct.new(:id, :name, :capital, :population, :region, :un_member, :openstreetmap, keyword_init: true)
end
