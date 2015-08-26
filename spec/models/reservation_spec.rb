require 'rails_helper'

RSpec.describe Reservation, type: :model do

  context '#reservations' do
    it 'has a user id' do
      reservation = create_reservation

      expect(reservation.user_id).to eq(2)
    end

    it 'has user trips' do
      reservation = create_reservation
      expect(reservation.reservation_trips).to eq([])
    end

    it 'has trips' do
      reservation = create_reservation
      expect(reservation.trips).to eq([])
    end
  end

  def create_reservation
    Reservation.new(user_id: 2)
  end
end
