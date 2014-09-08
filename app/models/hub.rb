class Hub < ActiveRecord::Base
  has_many :transactions

  validates :location_id, uniqueness: true

  def get_with_transactions
    {hub: self, transactions: transactions}
  end

  def self.get_all_with_transactions
    all.map{ |hub| hub.get_with_transactions }
  end
end
