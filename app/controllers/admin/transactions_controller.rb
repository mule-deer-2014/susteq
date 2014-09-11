class Admin::TransactionsController < ApplicationController
  before_filter :require_admin_signin

  def credits_by_kiosk
    kiosk_total_objects = Transaction.select("location_id as kiosk_id, sum(amount) as total").credits_sold.group("location_id").order("sum(amount)")
    obj_arr = kiosk_total_objects.map do |obj|
      p obj
      {location_id: obj.kiosk_id, total: obj.total}
    end
    respond_to do |format|
      format.json { render json: obj_arr }
    end
  end
end
