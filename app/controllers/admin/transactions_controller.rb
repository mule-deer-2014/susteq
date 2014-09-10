class TransactionsController < ApplicationController
  scope :created_before, ->(time) { where("created_at < ?", time) }
  scope :credits_sold, ->{where(transaction_type)}

  def most_recent_transactions
    Transaction.find(:all, :order => "transaction_time desc", :limit => 10).reverse
  end

  def sms_low

  end

  def total_credits_sold
    Transaction.find(:all, :)

    {location_id:location_id, amount:amount}
  end

end