# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Salman: Make sure you have a user_id = '1', as it sets all the values to that user.
# ['http://1000awesomethings.com/','http://edition.cnn.com/', '']
# @feed = RSSReader.new.create_rss_feed(url)

User.delete_all

User.create! email: 'admin@rss.com', first_name: 'Admin', role: 'admin', password: 'password', password_confirmation: 'password'
