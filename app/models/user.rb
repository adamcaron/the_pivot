class User < ActiveRecord::Base
  attr_accessor :password

  has_secure_password
  validates :username, presence: true,
            uniqueness: true
  has_many :reservations
  enum role: %w(default admin)
end
