class Transaction < ActiveRecord::Base
  belongs_to :pump
  belongs_to :kiosk
end