# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'
require "open-uri"
require_relative "cities"
require_relative "description"
require_relative "letters"

Letter.destroy_all
Inbox.destroy_all
HobbyTag.destroy_all
Hobby.destroy_all
User.destroy_all

randomizer = ('a'..'z').to_a

# def random_city
#   url = "https://countriesnow.space/api/v0.1/countries"
#   response = RestClient.get(url)

#   puts response

#   cities = []
#   array = JSON.parse(response)["data"]
#   array.each do |item|
#     item["cities"].each do |city|
#       cities << city
#     end
#   end
#   cities.sample
# end

puts "created hobbies"

20.times do

  user = User.create!(name:"#{Faker::Name.first_name} #{Faker::Name.middle_name}",
    email:"#{Faker::Name.first_name}@hotmail.com",
    gender:Faker::Gender.type,
    avatar: "https://avatars.dicebear.com/api/bottts/#{randomizer.sample(rand(1..26)).join}.svg" ,
    password:"111111",
    address: Cities::CITIES.sample,
    description: Description::DESCRIPTION.sample,
    age:rand(16..40))

    puts "Created user number #{user.id}"

    hobbies = []
    counter = 0
    while counter < 10
      hobby = Faker::Hobby.activity
      if hobby.exclude?" "
        puts "Added #{hobby}"
        hobbies << Hobby.create!(name: hobby)
        counter += 1
      end
    end

    3.times do
      hobby = hobbies.sample.id
      hobbytag = HobbyTag.find_by(hobby: hobby, user: user.id)
      unless hobbytag
        HobbyTag.create!(hobby_id: hobby, user_id: user.id)
      end
      puts "Hobby tag created"
    end

    user1 = User.create(name:"#{Faker::Name.unique.first_name} #{Faker::Name.middle_name}",
      email:"#{Faker::Name.first_name}@hotmail.com",
      gender:Faker::Gender.type,
      avatar: "https://avatars.dicebear.com/api/bottts/#{randomizer.sample(rand(1..26)).join}.svg" ,
      password:"111111",
      address: Cities::CITIES.sample,
      description: Description::DESCRIPTION.sample,
      age:rand(16..40))

      puts "created user number #{user1.id}"

      3.times do
        hobby = hobbies.sample.id
        hobbytag = HobbyTag.find_by(hobby: hobby, user: user1.id)
        unless hobbytag
          HobbyTag.create!(hobby_id: hobby, user_id: user1.id)
        end
        puts "Hobby tag created"
      end

  inbox = Inbox.new(first_user: user, second_user: user1)
  inbox.save!

  rand(5..15).times do
    letter = Letter.new(sender: user, receiver: user1, inbox: inbox, content: Letters::LETTERS.sample, subject: "#{Faker::Hacker.adjective} #{Faker::Hacker.verb}")
    puts "[#{letter.subject}]\t \t Letter.sent!"
    letter.save!

    letter = Letter.new(sender:user1, receiver: user, inbox: inbox,  content: Letters::LETTERS.sample, subject: "#{Faker::Hacker.adjective} #{Faker::Hacker.verb}")
    puts "[#{letter.subject}]\t \t Letter sent!"
    letter.save!
  end
end
