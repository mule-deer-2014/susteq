class Kiosk < Hub
  belongs_to :provider
  has_many :transactions, as: :transactable

  def credits_sold
    credit_sum = 0
    sales = transactions.where(transaction_code: 22)
    sales.each {|s| credit_sum += s.amount}
    credit_sum
  end

  def provider
    super || NullProvider.new
  end
end
