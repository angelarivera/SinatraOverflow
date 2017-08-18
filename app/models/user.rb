class User < ActiveRecord::Base
  has_many :questions, foreign_key: :author_id
  has_many :answers, foreign_key: :answerer_id
  has_many :comments
  has_many :votes

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    if  user.password == password
      return user
    else
      return nil
    end
  end
end
