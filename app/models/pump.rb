class Pump < ActiveRecord::Base
  belongs_to :water_service_provider
  has_many :transaction
end