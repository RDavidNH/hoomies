# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


cities = []
districts = []
users = []
types_obj = []

types = ['Villa', 'Appartement', 'Bureau', 'Studio', 'Manoir']

10.times do
    cities << City.create(
        name: Faker::Address.city,
        zip_code: Faker::Address.zip
    )
end

20.times do
    districts << District.create(
        name: Faker::Address.street_name,
        description: Faker::Lorem.paragraph(sentence_count: 5),
        city: cities[rand(0..cities.size)]
    )
end


10.times do |i|
    users << User.create(
        email: "hsadmin#{i}@yopmail.com",
        password: "adminadmin",
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        role: "user",
        phone: Faker::PhoneNumber.cell_phone_with_country_code,
        address: Faker::Address.full_address,
        city: cities[rand(0..cities.size)]
    )
end


5.times do |i|
    types_obj << Type.create(
        name: types[i],
        description: Faker::Lorem.paragraph(sentence_count: 5)
    )
end

puts districts.size 

20.times do |i|
    House.create(
        title: "House #{i+1}",
        description: Faker::Lorem.paragraph(sentence_count: 5),
        room_number: rand(1..6),
        address: Faker::Address.full_address,
        status: "available",
        district: districts.sample,
        user: users.sample,
        type: types_obj.sample,
    )
end