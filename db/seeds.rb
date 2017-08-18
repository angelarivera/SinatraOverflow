User.delete_all
Question.delete_all
Answer.delete_all
Vote.delete_all
Comment.delete_all

# for testing purposes, generate more questions/comments/votes, as compared to users
standard_create_number = 42

# USERS
5.times do
  user = User.new(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email
  )
  user.password = "password"
  user.save
end


# QUESTIONS
standard_create_number.times do
  user = User.all.sample.id
  title_part1 = [
    Faker::Seinfeld.character,
    Faker::TheFreshPrinceOfBelAir.celebrity,
    Faker::Friends.character,
    Faker::LordOfTheRings.character
  ].sample
  title_part2 =[
    Faker::Demographic.height(:imperial),
    Faker::Demographic.marital_status.downcase,
    Faker::Demographic.demonym.downcase,
  ].sample

  body_part1 = [
    Faker::MostInterestingManInTheWorld.quote,
    Faker::HowIMetYourMother.quote,
    Faker::TheFreshPrinceOfBelAir.quote
  ].sample

  Question.create(
  title: "Is #{ title_part1 } #{ title_part2 }?",
  description: "#{ Faker::Seinfeld.quote }",
  author_id: user
  )
end


# ANSWERS
standard_create_number.times do
  question = Question.all.sample.id
  user = User.all.sample.id
  description = [
    Faker::MostInterestingManInTheWorld.quote,
    Faker::Simpsons.quote,
    Faker::HitchhikersGuideToTheGalaxy.quote
  ].sample

  Answer.create(
  description: description,
  question_id: question,
  answerer_id: user
  )
end


# COMMENTS
standard_create_number.times do
  user = User.all.sample.id
  type = ["Answer", "Question"]

  Comment.create(
  description: Faker::TheFreshPrinceOfBelAir.quote,
  user_id: user,
  commentable_type: type.sample,
  commentable_id: rand(1..standard_create_number)
  )
end


# VOTES
# expect failures in seed data, as our validations state 1 vote for  <x> / user
200.times do
  user = User.all.sample.id
  type = ["Answer", "Question"]

  Vote.create(
  vote_value: [-1, 1].sample,
  user_id: user,
  votable_type: type.sample,
  votable_id: rand(1..standard_create_number)
  )
end
