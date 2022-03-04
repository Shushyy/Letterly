# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
randomizer = ('a'..'z').to_a

10.times do

  user = User.new(name:Faker::Name.unique.name,
                  email:Faker::Internet.email,
                  gender:Faker::Gender.type,
                  avatar: "https://avatars.dicebear.com/api/bottts/#{randomizer.sample(rand(1..26)).join}.svg" ,
                  password:"111111",
                  address:Faker::Address.city,
                  description:Faker::Quote.most_interesting_man_in_the_world,
                  age:rand(18..40))

  user1 = User.new(name:Faker::Name.unique.name,
                  email:Faker::Internet.email,
                  gender:Faker::Gender.type,
                  avatar: "https://avatars.dicebear.com/api/bottts/#{randomizer.sample(rand(1..26)).join}.svg" ,
                  password:"111111",
                  address:Faker::Address.city,
                  description:Faker::Quote.most_interesting_man_in_the_world,
                  age:rand(18..40))

  user.save!
  user1.save!

  inbox = Inbox.new(first_user:user, second_user: user1)
  inbox.save!

  rand(5..15).times do
    letter = Letter.new(sender: user, receiver: user1, inbox: inbox, content: Faker::TvShows::BojackHorseman.quote, subject: Faker::TvShows::BojackHorseman.character)
    puts "[#{letter.subject}]\t \t Letter.sent!"
    letter.save!

    letter = Letter.new(sender:user1, receiver: user, inbox: inbox,  content: Faker::TvShows::BojackHorseman.quote, subject: Faker::TvShows::BojackHorseman.character)
    puts "[#{letter.subject}]\t \t Letter sent!"
    letter.save!
  end


end
