module PerspectiveSummary
  def credits_by_kiosk
    chart_data_array = []
    #Query for Stacked Bar Chart
    @month_by_kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 20 or transaction_code = 21").group("extract(month from transaction_time),location_id")
    #Query for Bar Chart and Table
    @kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 20 or transaction_code = 21").group("location_id").order("sum(amount)")

    stacked_data_to_display = []
    (Date.today.month-5..Date.today.month).each do |month|
      month_hash[:month] = month
      @month_by_kiosk_total_obj_arr.select{|obj| obj.month == month }.each do |obj|
        location_key = "location_id".concatenate(obj.location_id.to_s).to_sym
        month_hash[location_key] = obj.total
      end
      stacked_data_to_display.push(month_hash)
    end

    #Prepare data for Normalchart
    @kiosk_total_obj_arr.each do |obj|
      kiosk_obj = {location_id: obj.location_id, total: obj.total}
      chart_data_array.push(kiosk_hash)
    end

    #Create chart obj
    data_to_display = {
    xAxisTitle: "Kiosk Location Id",
    yAxisTitle: "Credits Sold",
    chartData: chart_data_array,
    chartType: "bar"
    };
    #Return as json obj
    @viz_data = data_to_display.to_json
  end

  def dispensed_by_month(pump)
    @dispensed_by_month = Transaction.select("sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 1 and location_id = #{pump.location_id}").group("extract(month from transaction_time)")
    #Prepare data for Normalchart
    chart_data_array = []
    (Date.today.month-5..Date.today.month).each do |month|
      pumped_in_month = @dispensed_by_month.select{|obj| obj.month == month }[0].total
      chart_data_array.push({month: month, total: pumped_in_month})
    end
    #Create chart obj
    data_to_display = {
    xAxisTitle: "Month",
    yAxisTitle: "Water Dispensed",
    chartData: chart_data_array,
    chartType: "bar"
    };
    #Return as json obj
    @viz_data = data_to_display.to_json
  end

  def credits_sold_by_kiosk(kiosk)
    @month_by_kiosk_total_obj_arr = Transaction.select("sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 20 and transaction_code = 21 and location_id = #{kiosk.location_id}").group("extract(month from transaction_time)")
  end
end



# Credits Sold by Kiosk (by Month)
# Transaction.select(“location_id, sum(amount) as total”)
# .where(“transaction_code = 20 or transaction_code = 21)
# .group(“location_id”,”extract(month from transaction_time)
# Credits bought by Kiosk
# Transaction.select(“location_id, sum(amount) as total”)
# .where(“transaction_code = 23”)
# .group(“location_id”)
# amount where transaction_code = 23 + amount where transaction_code = 23 AND (starting_credit - ending_credit) < 0
# Credits remaining by Kiosk
# Transaction.select(“location_id, sum(amount) as total”)
# .where(“transaction_code = 23”)
# .group(“location_id”)
# amount where transaction_code = 23 + amount where transaction_code = 23 AND (starting_credit - ending_credit) > 0
# Water Dispensed by Pump
# Transaction.select(“location_id, sum(amount) as total”)
# .where(“transaction_code = 1”)
# .group(“location_id”)
# Count of Errors by Kiosk Table over last 30 days
# GPRS Errors - count(transaction_code = 39 and amount=101)
# Transaction.select(“location_id, transaction_time, count(amount) as count”)
# .where(“transaction_code=39 AND amount =101 AND transaction_time > Date.today - 30”)
# .group(“location_id)
# RFID Errors - count(transaction_code = 39 and amount=111)
# BAT Low Errors - count(transaction_code = 39 and amount=132)
# BAT OK Errors - count(transaction_code = 39 and amount=133)
# Last Error by Kiosk
# GPRS Errors
# Transaction.select(“location_id, transaction_time”)
# .where(“transaction_code=39 AND amount =101)
# .group(“location_id)
# .order(“transaction_time”)
# .first
# RFID Errors - count(transaction_code = 39 and amount=111)
# BAT Status
# Transaction.select(“location_id, transaction_time as day”)
# .where(“transaction_code=39 AND (amount =132 OR amount=133))
# .group(“location_id)
# .order(“transaction_time”)
# .first
# 133 is BAT ok, 132 is BAT not ok
# SMS Balance on Sim Card by Pump
# Transaction.select(“location_id, extract(day from transaction_time), amount”)
# .where(“transaction_code=41)
# .group(“location_id)
# .order(“transaction_time”)
# .first
