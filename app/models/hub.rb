class Hub < ActiveRecord::Base
  belongs_to :provider
  has_many :transactions

  validates :location_id, uniqueness: true
end
