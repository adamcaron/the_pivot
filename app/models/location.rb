class Location < ActiveRecord::Base
  validates :continent, :description , presence: true
  validates :continent, uniqueness: true
  has_many :listings
end