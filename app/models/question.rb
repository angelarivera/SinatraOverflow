class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :answerers, through: :answers

  validates :author_id, presence: { message: "must have an author_id" }

  def self.most_recent
    Question.order(created_at: :desc).limit(15)
  end
end
