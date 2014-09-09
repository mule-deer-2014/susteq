class Hub < ActiveRecord::Base
  has_many :transactions

  validates :location_id, uniqueness: true, numericality: { only_integer: true}
  validates :location_id, presence: true
  validates :latitude, numericality: { :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90}
  validates :longitude, numericality: { :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180}
  validates :status_code, numericality: { only_integer: true}

  after_save :find_loose_transactions

  def find_loose_transactions
    transactions << Transaction.where(location_id: location_id)
  end

  def get_with_transactions
    {hub: self, transactions: transactions}
  end

  def self.get_all_with_transactions
    all.map{ |hub| hub.get_with_transactions }
  end

  def self.get_many_with_transaction(hubs)
    hubs.map{ |hub| hub.get_with_transactions }
  end

  def self.get_all_transactions
    all.map{ |hub| hub.transactions }.flatten
  end
end
