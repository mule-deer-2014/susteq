class Pump < Hub
  belongs_to :provider
  has_many :transactions, as: :transactable
end