require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.create(user_id: 2) }

  context '#reservations' do
    xit 'has a user id' do
      expect(reservation.user_id).to eq(2)
    end
  end
end
