class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :answerers, through: :answers, source: :user

  validates :author_id, presence: { message: "must have an author_id" }
end
