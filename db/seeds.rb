# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb に追記
order_map = {
  "無級"=>0,
  "準5級"=>1, "5級"=>2,
  "準4級"=>3, "4級"=>4,
  "準3級"=>5, "3級"=>6,
  "準2級"=>7, "2級"=>8,
  "準1級"=>9, "1級"=>10,
  "初段"=>11, "弐段"=>12, "参段"=>13, "四段"=>14
}

order_map.each do |name, order|
  clean = name.strip
  r = Rank.find_or_create_by!(name: clean)
  r.update!(display_order: order)
end
