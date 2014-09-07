class PumpsController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = Provider.find(params[:provider_id]).pumps
    transactions = []
    @pumps.each do |p|
      p.transactions.where(transaction_code: 1).each do |t|
        transactions << t
      end
    end
    sum = 0
    transactions.each do |t|
      sum += t.amount
    end
    @total_dispensed = sum
  end

  def show
    @pump = Pump.find(params[:id])
  end
end
