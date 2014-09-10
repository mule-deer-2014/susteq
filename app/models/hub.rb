class Hub < ActiveRecord::Base
  has_many :transactions

  ONLY_NUMBERS = /\A[0-9]+\z/

  validates :name, length: { maximum: 50 }
  validates :type, presence: true
  validates :location_id, presence: true, uniqueness: true, numericality: { only_integer: true}
  validates :latitude, numericality: { :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90}, allow_nil: true
  validates :longitude, numericality: { :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180}, allow_nil: true
  validates :status_code, numericality: { only_integer: true}
  validates :owner_phone_number, format: { with: ONLY_NUMBERS, message:"should only have numeric values." }, allow_nil: true
  validates :owner_sim_number, format: { with: ONLY_NUMBERS, message:"should only have numeric values." }, allow_nil: true

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

  def get_last_transaction
    transactions.last
  end
end
