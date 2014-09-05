class Purchase < ActiveRecord::Base
  belongs_to :water_service_provider
  belongs_to :kiosk
end