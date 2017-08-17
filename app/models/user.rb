class User < ActiveRecord::Base
  has_many :questions, foreign_key: :author_id
  has_many :answers, foreign_key: :answerer_id
  has_many :comments
  has_many :votes
end
