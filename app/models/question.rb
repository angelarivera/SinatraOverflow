class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :answerers, through: :answers, source: :user

  validates :author_id, presence: { message: "must have an author_id" }

  validates :title, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false

  def self.most_recent
    Question.order(created_at: :desc).limit(15)
  end

  def total_votes
    self.votes.inject(0){|sum, vote| sum + vote.vote_value }
  end

  def total_answers
    self.answers.length
  end

  def total_comments
    self.comments.length
  end

end
