class User < ActiveRecord::Base
  has_many :questions, foreign_key: :author_id
  has_many :answers, foreign_key: :answerer_id
  has_many :comments
  has_many :votes

  validates :username, presence: { message: "should not be blank" }
  validates :email, presence: { message: "should not be black" }, uniqueness: true
  validates :password_hash, presence: { message: "should not be black" }#TODO: how to validate empty passwords


  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return nil if user == nil
    return user if user.password == password
    nil
  end
end
