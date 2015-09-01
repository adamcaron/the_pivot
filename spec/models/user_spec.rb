require 'rails_helper'

RSpec.describe User, type: :model do
  context 'default user' do
    it 'exists when created' do
      user = create_user

      expect(user.username).to eq("Bob")
    end

    it 'is a registered user' do
      user = create_user

      expect(check_role(user)).to eq("registered_user")
    end
  end

  def check_role(user)
    if user.platform_admin?
      "platform_admin"
    elsif user.business_admin?
      "business_admin"
    else
      "registered_user"
    end
  end

  def create_user
    User.create(username: "Bob", password:"123")
  end
end
