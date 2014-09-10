class Admin::TransactionsController < ApplicationController
  before_filter :require_admin_signin

  def credits_by_kiosk
    kiosk_total_objects = Transaction.select("location_id as kiosk_id, sum(amount) as total").credits_sold.group("location_id").order("sum(amount)")
    obj_arr = kiosk_total_objects.map do |obj|
      {location_id: obj.kiosk_id, total: obj.total}
    end
    respond_to do |format|
      json { render json: obj_arr }
    end
  end

end

  # scope :created_before, ->(time) { where("created_at < ?", time) }
  # scope :credits_sold, ->{where(transaction_type: [20,21])}
  # scope :water_sold, ->{where(transaction_type:1)}

  # def most_recent_transactions
  #   Transaction.find(:all, :order => "transaction_time desc", :limit => 10).reverse
  # end

  # def total_water
  #   Transaction.water_sold.group(:pump).sum(:amount)
  # end

  # def total_credits_sold
  #   Transactions.order(transaction_time: :desc).limit(100).credits_sold().group("location_id").select("location_id, sum(amount)")
  #   {location_id:location_id, amount:amount}
  # end
