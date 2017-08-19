class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id,
  uniqueness: {
    scope: [ :votable_id, :votable_type ],
    message: "can only vote for a particular object once "},
  presence: { message: "must have user_id" }


end
