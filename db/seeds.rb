User.delete_all
Question.delete_all
Answer.delete_all
Vote.delete_all
Comment.delete_all


# USERS
10.times do
  User.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password_hash: "password"
  )
end


# QUESTIONS
10.times do
  user = User.all.sample.id

  Question.create(
  title: Faker::Book.title,
  description: Faker::Lorem.sentence,
  author_id: user
  )
end


# ANSWERS
10.times do
  question = Question.all.sample.id
  user = User.all.sample.id

  Answer.create(
  description: Faker::Lorem.sentence,
  question_id: question,
  answerer_id: user
  )
end


# COMMENTS
10.times do
  user = User.all.sample.id
  type = ["Answer", "Question"]

  Comment.create(
  description: Faker::Lorem.sentence,
  user_id: user,
  commentable_type: type.sample,
  commentable_id: rand(1..10)
  )
end


# VOTES
10.times do
  user = User.all.sample.id
  type = ["Answer", "Question"]

  Vote.create(
  vote_value: [-1, 1].sample,
  user_id: user,
  votable_type: type.sample,
  votable_id: rand(1..10)
  )
end
