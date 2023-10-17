# Faker helps you generate realistic test data, and populate
# your database with more than a couple of records while you're
# doing development.
#
# It comes in very handy for taking screenshots (taking screen-
# shots for a personal project) and it was the original impetus
# for the creation of this gem).

require 'faker'

# Ensure Faker generates unique data by resetting its seed
Faker::UniqueGenerator.clear

mucho_amigo_1 = MuchoAmigo.create!(
  full_name: Faker::Name.unique.name,
  user_name: Faker::Internet.username,
  email: "mucho.amigo.1@sagacicweb.com",
  password: "abcd1234%^&*",
  password_confirmation: "abcd1234%^&*",
  address: "",
  street_number: "28980", 
  street_name: "Gladiolus",
  street_suffix: "Drive", 
  city: "Santa Clarita",
  state_abbreviation: "CA", 
  country_code: "US", 
  postal_code: "91387",
  latitude: "", 
  longitude: "",
  phone: Faker::PhoneNumber.unique.cell_phone,
  party_animal: Faker::Boolean.boolean(true_ratio: 0.65),
  personal_bio: Faker::Lorem.unique.paragraphs(number:3, supplemental: true),
  confirmed_at: Time.current
)
mucho_amigo_2 = MuchoAmigo.create!(
  full_name: Faker::Name.unique.name,
  user_name: Faker::Internet.username,
  email: "mucho.amigo.2@sagacicweb.com",
  password: "abcd1234%^&*",
  password_confirmation: "abcd1234%^&*",
  address: "",
  street_number: "1187", 
  street_name: "Ojai",
  street_suffix: "Street", 
  city: "Fillmore",
  state_abbreviation: "CA", 
  country_code: "US",
  postal_code: "93015",
  latitude: "", 
  longitude: "",
  phone: Faker::PhoneNumber.unique.cell_phone,
  party_animal: Faker::Boolean.boolean(true_ratio: 0.65),
  personal_bio: Faker::Lorem.unique.paragraphs(number:3, supplemental: true),
  confirmed_at: Time.current
)
mucho_amigo_3 = MuchoAmigo.create!(
  full_name: Faker::Name.unique.name,
  user_name: Faker::Internet.username,
  email: "mucho.amigo.3@sagacicweb.com",
  password: "abcd1234%^&*",
  password_confirmation: "abcd1234%^&*",
  address: "",
  street_number: "19837", 
  street_name: "93rd",
  street_suffix: "Street", 
  city: "California City",
  state_abbreviation: "CA", 
  country_code: "US",
  postal_code: "93505",
  latitude: "", 
  longitude: "",
  phone: Faker::PhoneNumber.unique.cell_phone,
  party_animal: Faker::Boolean.boolean(true_ratio: 0.65),
  personal_bio: Faker::Lorem.unique.paragraphs(number:3, supplemental: true),
  confirmed_at: Time.current
)
mucho_amigo_4 = MuchoAmigo.create!(
  full_name: Faker::Name.unique.name,
  user_name: Faker::Internet.username,
  email: "mucho.amigo.4@sagacicweb.com",
  password: "abcd1234%^&*",
  password_confirmation: "abcd1234%^&*",
  address: "",
  street_number: "218", 
  street_name: "Cedar",
  street_suffix: "Ave", 
  city: "Miami",
  state_abbreviation: "AZ", 
  country_code: "US", 
  postal_code: "85539",
  latitude: "", 
  longitude: "",
  phone: Faker::PhoneNumber.unique.cell_phone,
  party_animal: Faker::Boolean.boolean(true_ratio: 0.65),
  personal_bio: Faker::Lorem.unique.paragraphs(number:3, supplemental: true),
  confirmed_at: Time.current
)
mucho_amigo_5 = MuchoAmigo.create!(
  full_name: Faker::Name.unique.name,
  user_name: Faker::Internet.username,
  email: "mucho.amigo.6@sagacicweb.com",
  password: "abcd1234%^&*",
  password_confirmation: "abcd1234%^&*",
  address: "",
  street_number: "3925", 
  street_name: "Monte Vista",
  street_suffix: "Drive", 
  city: "Medford",
  state_abbreviation: "OR", 
  country_code: "US", 
  postal_code: "97504",
  latitude: "", 
  longitude: "",
  phone: Faker::PhoneNumber.unique.cell_phone,
  party_animal: Faker::Boolean.boolean(true_ratio: 0.65),
  personal_bio: Faker::Lorem.unique.paragraphs(number:3, supplemental: true),
  confirmed_at: Time.current
)

location_1 = MuchoLocation.create!(
  location_name: "Native Fields",
  location_description: "Native Fields is owned by sisters, Chef Cat Castaneda and Christine Cornwell. The restaurant is in honor of their late father, Marcel Castaneda, who passed away from cancer in 2016. Native Fields opened two years later in 2018.\nChef Cat is a graduate of the Culinary Institute of America. Returning to Los Angeles from New York, she worked with her mentor and James Beard award winner, Suzanne Goin at fine dining establishments Lucques and a.o.c. Cat also helped to open Silverlake’s first organic fast-casual restaurant, Forage.\nChef Cat is a benefactor of an organic farm at Cal Poly Pomona where she teaches students and harvests produce for her restaurant. On a grander scale, she also feeds seniors and families through organizations like YWCA.",
  location_phone: "+16269771110",
  location_email: "hello@nativefieldsla.com",
  location_website_url: "https://nativefieldsla.com/",
  location_address: "",
  location_street_number: "18750",
  location_street_name: "Amar",
  location_street_suffix: "Rd",
  location_city: "Walnut",
  location_state_abbreviation: "CA",
  location_postal_code: "91789",
  location_country_code: "US",
  location_latitude: "",
  location_longitude: "",
  location_available: true
)

location_2 = MuchoLocation.create!(
  location_name: "Home Restaurant",
  location_description: "For over 20 years, Aram and Rose Serobian have been inviting friends and neighbors into Home restaurant, a Craftsman-style house in Los Feliz, which they said reminded them of back home.",
  location_phone: "+13239908016",
  location_email: "",
  location_website_url: "https://www.homerestaurantla.com/",
  location_address: "",
  location_street_number: "1760",
  location_street_name: "Hillhurst",
  location_street_suffix: "Ave",
  location_city: "Los Angeles",
  location_state_abbreviation: "CA",
  location_postal_code: "90027",
  location_country_code: "US",
  location_latitude: "",
  location_longitude: "",
  location_available: true
)
location_3 = MuchoLocation.create!(
  location_name: "TreePeople",
  location_description: "TreePeople's mission is to inspire, engage and support people to take personal responsibility for the urban environment, making it safe, healthy, fun and sustainable and to share our process as a model for the world.",
  location_phone: "+18187534600",
  location_email: "info@treepeople.org",
  location_website_url: "http://www.treepeople.org/",
  location_address: "",
  location_street_number: "12601",
  location_street_name: "Mulholland",
  location_street_suffix: "Dr",
  location_city: "Beverly Hills",
  location_state_abbreviation: "CA",
  location_postal_code: "90210",
  location_country_code: "US",
  location_latitude: "",
  location_longitude: "",
  location_available: false
)
location_4 = MuchoLocation.create!(
  location_name: "Gladstone's Restaurant",
  location_description: "With over 50 years in operation, we are celebrating the Golden Era of Gladstones by reviving our favorite stories, recipes, and drinks. Join us for a memorable family occasion.",
  location_phone: "+13104543474",
  location_email: "hello@gladstones.com",
  location_website_url: "http://www.gladstones.com/",
  location_address: "",
  location_street_number: "17300",
  location_street_name: "Pacific Coast",
  location_street_suffix: "Hwy",
  location_city: "Pacific Palisades",
  location_state_abbreviation: "CA",
  location_postal_code: "90272",
  location_country_code: "US",
  location_latitude: "",
  location_longitude: "",
  location_available: true
)
location_5 = MuchoLocation.create!(
  location_name: "Paradise Cove Beach Café",
  location_description: "Enjoy the iconic Southern California experience at our quintessential California Beach Restaurant. Not only is Paradise Cove the best beach in Malibu, it's the best beach in the world! Smell the fresh sea air and gaze at the beautiful blue Pacific Ocean with a cocktail in hand. Indulge in our wide selection of breakfast, lunch, and dinner items. Walk along the beach and look at the homes of movie and rock stars, billionaires and Wall Street hot shots, plus so much more! Whether you're in a bikini, wheelchair, high-chair, or anything in-between, we have something for everyone. Kick back and experience the magic of Paradise.",
  location_phone: "+13104572503",
  location_email: "",
  location_website_url: "https://paradisecovemenu.com/",
  location_address: "",
  location_street_number: "28128",
  location_street_name: "Pacific Coast",
  location_street_suffix: "Hwy",
  location_city: "Malibu",
  location_state_abbreviation: "CA",
  location_postal_code: "90265",
  location_country_code: "US",
  location_latitude: "",
  location_longitude: "",
  location_available: true
)
location_6 = MuchoLocation.create!(
  location_name: "Cafe Beaujolais",
  location_description: "Located in an 1893 Victorian farmhouse in the seaside town of Mendocino, the restaurant is surrounded by a large and beautiful garden filled with antique roses, edible flowers and unusual plants. ",
  location_phone: "+17079375614",
  location_email: "",
  location_website_url: "http://cafebeaujolais.com/",
  location_address: "",
  location_street_number: "961",
  location_street_name: "Ukiah",
  location_street_suffix: "Street",
  location_city: "Mendocino",
  location_state_abbreviation: "CA",
  location_postal_code: "95460",
  location_country_code: "US",
  location_latitude: "",
  location_longitude: "",
  location_available: true
)
location_7 = MuchoLocation.create!(
  location_name: "The Deck on Laguna",
  location_description: "A unique oceanfront dining experience in Laguna Beach, specializing in fresh seafood and creative cocktails served beachside with a smile. The Deck is one of the few Laguna Beach waterfront restaurants on the beach, offering a seaside restaurant experience in South Orange County.",
  location_phone: "+19497558788",
  location_email: "",
  location_website_url: "https://www.deckonlaguna.com/",
  location_address: "",
  location_street_number: "627",
  location_street_name: "Sleepy Hollow",
  location_street_suffix: "Ln",
  location_city: "Laguna Beach",
  location_state_abbreviation: "CA",
  location_postal_code: "92651",
  location_country_code: "US",
  location_latitude: "",
  location_longitude: "",
  location_available: true
)

party_1 = MuchoParty.create!(
  party_name: "Railing at Native Fields About Coding",
  party_date: "2023-10-17",
  party_time: "2023-10-17T04:00:00.000-07:00",
  party_location_id: location_1.id,
  party_host_id: mucho_amigo_1.id
)

party_2 = MuchoParty.create!(
  party_name: "Coding at Home Restaurant Till Dawn",
  party_date: "2023-11-04",
  party_time: "2023-11-04T17:30:00.080-07:00",
  party_location_id: location_2.id,
  party_host_id: mucho_amigo_2.id
)

party_3 = MuchoParty.create!(
  party_name: "Cathcing Rails in Knarly Surf at Paradise Cove",
  party_date: "2023-09-15",
  party_time: "2023-09-15T10:00:00.000-07:00",
  party_location_id: location_3.id,
  party_host_id: mucho_amigo_3.id,
)

party_4 = MuchoParty.create!(
  party_name: "A Ruby of a Party at Gladstone's",
  party_date: "2023-10-01",
  party_time: "2023-10-01T03:30:00.000-07:00",
  party_location_id: location_5.id,
  party_host_id: mucho_amigo_4.id
)

party_5 = MuchoParty.create!(
  party_name: "Coding at Cafe Beaujolais Till Dawn",
  party_date: "2023-09-30",
  party_time: "2023-09-30T02:30:00.000-07:00",
  party_location_id: location_6.id,
  party_host_id: mucho_amigo_5.id
)

party_6 = MuchoParty.create!(
  party_name: "Hitting the Deck with Awesome Code",
  party_date: "2023-11-27",
  party_time: "2023-11-27T01:00:00.000-07:00",
  party_location_id: location_7.id,
  party_host_id: mucho_amigo_1.id,
)

party_7 = MuchoParty.create!(
  party_name: "Compiling with The Tree People",
  party_date: "2023-12-31",
  party_time: "2023-12-31T04:59:59.999-07:00",
  party_location_id: location_4.id,
  party_host_id: mucho_amigo_1.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_2.id,
  party_id: party_1.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_3.id,
  party_id: party_1.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_1.id,
  party_id: party_2.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_5.id,
  party_id: party_2.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_2.id,
  party_id: party_3.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_4.id,
  party_id: party_3.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_4.id,
  party_id: party_4.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_5.id,
  party_id: party_4.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_1.id,
  party_id: party_5.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_3.id,
  party_id: party_5.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_4.id,
  party_id: party_6.id
)

MuchoGuest.create!(
  amigo_id: mucho_amigo_1.id,
  party_id: party_6.id
)

puts "#{MuchoAmigo.count} amigos created"
puts "#{MuchoLocation.count} locations created"
puts "#{MuchoParty.count} parties created"
puts "#{MuchoGuest.count} guests created"