require 'random_data'

#create Topics
2.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Users
5.times do

  User.create!(
    name: RandomData.random_name,
    email:  RandomData.random_email,
    password:   RandomData.random_sentence
  )
end
users = User.all

#user = User.first
#user.update_attributes!(
#  email: 'michael.demarco65@gmail.com',
#  password: 'helloworld'
#)

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

# Create Posts
2.times do

  Post.create!(
    user: users.sample,
    topic: topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments

100.times do
  Comment.create!(

    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
