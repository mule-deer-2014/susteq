class KiosksController < ApplicationController
  layout "provider_application"

  def index
    @kiosks = Provider.find(params[:provider_id]).kiosks
    transactions = []
    @kiosks.each do |k|
      k.transactions.where(transaction_code: 22).each do |t|
        transactions << t
      end
    end
    sum = 0
    transactions.each do |t|
      sum += t.amount
    end
    @total_credits_sold = sum
  end

  def show
    @kiosk = Kiosk.find(params[:id])
  end
end
