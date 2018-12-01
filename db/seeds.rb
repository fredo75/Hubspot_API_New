# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Creating 10 leads...'
10.times do |i|
  contact = Contact.create!(
    firstname: Faker::FunnyName.name,
    lastname: Faker::Name.name,
    email: Faker::Internet.email,
    company: Faker::Company.name
  )
  puts "#{i + 1}. #{contact.firstname}"
end
puts 'Finished!'
