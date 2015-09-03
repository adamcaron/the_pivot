require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) {Reservation.create(user_id: 2)}

  context '#reservations' do
    it 'has a user id' do
      expect(reservation.user_id).to eq(2)
    end
  end
end
