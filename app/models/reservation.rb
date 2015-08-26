class Reservation < ActiveRecord::Base
  belongs_to :user
  has_many :reservation_listings
  has_many :listings, through: :reservation_listings

  validates :guest_id, :status, :listing_id, presence: true
  attr_accessor :cart

  enum status: %w(Ordered Paid Cancelled Completed)
  scope :status, -> (status) { where status: status }

end
