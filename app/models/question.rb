class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :answerers, through: :answers

  validates :author_id, presence: { message: "must have an author_id" }

  validates :title, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false

  def self.most_recent
    Question.order(created_at: :desc).limit(15)
  end

  def self.trending
    Question.all.sort{ |x,y| y.trending_score <=> x.trending_score }
  end

  def self.highest_voted
    Question.all.sort{ |x,y| y.total_votes <=> x.total_votes }
  end

  def trending_score
    score = (self.total_votes * 1)
    score += (self.total_comments * 2)
    score += (self.total_answers * 3)
    return score
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
