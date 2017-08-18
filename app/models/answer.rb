class Answer < ActiveRecord::Base

  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  def points
    p votes
    p votes.reduce(0) {|sum, vote| sum + vote.vote_value}
    # votes.sum(:vote_value)
  end

end
