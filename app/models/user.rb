class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true,
            uniqueness: true
  has_many :reservations
  has_many :user_roles
  has_many :roles, through: :user_roles

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def business_admin?
    roles.exists?(name: "business_admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end
end
