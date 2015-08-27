class Location < ActiveRecord::Base
  validates :continent, presence: true
  has_many :listings
end
