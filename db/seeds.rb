# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv = CSV.read(File.join(Rails.root, "db", "cities2.csv"), :encoding => 'windows-1251:utf-8', :headers => true)
csv.each do |city|
	City.create(name: city['name'], state: city['state'], latitude: city['latitude'], longitude: city['longitude'], population: city['population'])
end