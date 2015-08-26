class Reservation < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :listing

  validates   :status, :listing_id, presence: true

  attr_accessor :cart

  enum status: %w(Ordered Paid Cancelled Completed)
  scope :status, -> (status) { where status: status }

end
