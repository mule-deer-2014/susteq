class Admin::TransactionsController < ApplicationController
  before_filter :require_admin_signin

  def credits_by_kiosk
    kiosk_total_objects = Transaction.select("location_id as kiosk_id, sum(amount) as total").where("transaction_code = 20 or transaction_code = 21").group("location_id").order("sum(amount)")
    kiosk_total_objects.each do |obj|
      hash = {location_id: obj.location_id, type: "kiosk", total: obj.total}
      obj_arr.push(hash)
    end
    render json: obj_arr
  end
end

