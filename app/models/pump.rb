class Pump < Hub
  belongs_to :provider
  has_many :transactions, as: :transactable

  def water_dispensed
    water_sum = 0
    dispenses = transactions.where(transaction_code: 1)
    dispenses.each {|s| water_sum += s.amount}
    water_sum
  end

  def provider
    super || NullProvider.new
  end
end