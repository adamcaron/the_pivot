class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true,
            uniqueness: true
  has_many :reservations
  has_many :user_roles
  has_many :roles, through: :user_roles

  def platform_admin?
    roles.exists?(title: "platform_admin")
  end

  def business_admin?
    roles.exists?(title: "business_admin")
  end

  def registered_user?
    roles.exists?(title: "registered_user")
  end
end
