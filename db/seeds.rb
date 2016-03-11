require "random_data"
#create Users
User.create!(
   email:    'aberanderson@gmail.com',
   password: 'helloworld'
 )
User.create!(
   email:    'member@gmail.com',
   password: 'helloworld'
 )
users = User.all

#Create Topics
5.times do
  Topic.create!(
  title: RandomData.random_sentence,
  user: users.sample
  )
end
topics = Topic.all

#Create Bookmarks
20.times do
  Bookmark.create!(
  url: RandomData.random_http,
  topic: topics.sample
  )
end
bookmarks = Bookmark.all

puts "Seed finished"
puts "#{User.count} Users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
