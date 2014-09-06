class Transaction < ActiveRecord::Base
  belongs_to :kiosk
  belongs_to :pump
end