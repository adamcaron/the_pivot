class Listing < ActiveRecord::Base
  validates   :cost, :name, :location_id, presence: true
  validates   :name, length: { maximum: 25 }
  belongs_to  :location
  has_many    :reservations

  has_attached_file :image, :storage => :s3, :bucket => ENV['AWS_BUCKET']
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
