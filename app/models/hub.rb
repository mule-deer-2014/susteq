class Hub < ActiveRecord::Base
  has_many :transactions

  validates :location_id, uniqueness: true
end
