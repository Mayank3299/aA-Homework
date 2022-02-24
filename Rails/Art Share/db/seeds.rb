# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all

user1= User.create!(username: "Mayank Agarwal")
user2= User.create!(username: "Arpit Agarwal")
user3= User.create!(username: "Rahul Agarwal")

a1= Artwork.create!(title: "Ruggeri", image_url: "google.com", artist_id: user1.id)
a2= Artwork.create!(title: "Bismillah", image_url: "google1.com", artist_id: user2.id)

as1= ArtworkShare.create!(artwork_id: a1.id, viewer_id: user3.id)
as2= ArtworkShare.create!(artwork_id: a2.id, viewer_id: user1.id)
