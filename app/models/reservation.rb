class Reservation < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :listing

  validates   :user_id,
              :status,
              :listing_id,
              :check_in,
              :check_out,
              :total_cost, presence: true

  attr_accessor :cart

  enum status: %w(Ordered Paid Cancelled Completed)
  scope :status, -> (status) { where status: status }

end
