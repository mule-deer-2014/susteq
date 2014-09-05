class Hub < ActiveRecord::Base
  belongs_to :water_service_provider
  has_many :transactions
end