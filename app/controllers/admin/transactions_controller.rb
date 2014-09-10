class TransactionsController < ApplicationController
  before_filter :require_admin_signin

  scope :created_before, ->(time) { where("created_at < ?", time) }
  scope :credits_sold, ->{where(transaction_type: [20,21])}
  scope :water_sold, ->{where(transaction_type:1)}

  def most_recent_transactions
    Transaction.find(:all, :order => "transaction_time desc", :limit => 10).reverse
  end

  def total_water
    Transaction.water_sold.group(:pump).sum(:amount)
  end

  def total_credits_sold
    Transactions.order(transaction_time: :desc).limit(100).credits_sold().group(:kiosk).select("location_id, sum(amount)")
    {location_id:location_id, amount:amount}
  end

end