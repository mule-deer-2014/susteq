class Kiosk < Hub
  belongs_to :provider
  has_many :transactions
end