require 'rails_helper'

RSpec.describe Reservation, type: :model do

  context '#reservations' do
    it 'has a user id' do
      reservation = create_reservation

      expect(reservation.user_id).to eq(2)
    end

    it 'has user listings' do
      reservation = create_reservation
      expect(reservation.reservation_listings).to eq([])
    end

    it 'has listings' do
      reservation = create_reservation
      expect(reservation.listings).to eq([])
    end
  end

  def create_reservation
    Reservation.new(user_id: 2)
  end
end
