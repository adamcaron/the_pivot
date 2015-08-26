class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_listings
  has_many :listings, through: :order_listings

  attr_accessor :cart

  enum status: %w(Ordered Paid Cancelled Completed)
  scope :status, -> (status) { where status: status }

end
