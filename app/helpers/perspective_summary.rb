module PerspectiveSummary
  #CREDITS SOLD
  def credits_by_kiosk_for_all_table
    chart_data_array = []
    #Query for Bar Chart and Table
    kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 20 or transaction_code = 21").group("location_id").order("sum(amount)")
    #Prepare data for Normalchart
    kiosk_total_obj_arr.each do |obj|
      chart_data_array.push({location_id: obj.location_id, total: obj.total})
    end
    return chart_data_array
  end

  def getMonthName(month_number)
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    months[month_number-1]
  end

  def credits_by_kiosk_by_month
    #Query for Stacked Bar Chart
    month_by_kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 20 or transaction_code = 21").group("extract(month from transaction_time),location_id")
    stacked_data_to_display = []
    kiosk_location_array = month_by_kiosk_total_obj_arr.map{ |obj| obj.location_id}.uniq
    stacked_data_to_display = kiosk_location_array.map do |kiosk_id|
      values = month_by_kiosk_total_obj_arr.select{|obj| obj.location_id == kiosk_id }.map do |trans|
        {x: getMonthName(trans.month), y:trans.total}
      end
      {key: "Kiosk Location Id #{kiosk_id}", values: values}
    end
    data_to_display = {yAxisTitle: "Credits Sold By Month", chartData:stacked_data_to_display, chartType: "stacked"};

    # (Date.today.month-5..Date.today.month).each do |month|
    #   kiosk_hash = {}
    #   # month_hash[:month] = month
    #   if month_by_kiosk_total_obj_arr.select{|obj| obj.month == month }.length > 0
    #     month_by_kiosk_total_obj_arr.select{|obj| obj.month == month }.sort.each do |obj|
    #       location_key = "location_id ".concat(obj.location_id.to_s).to_sym
    #       # month_hash[location_key] = obj.total
    #       # labels_array.push(location_key)
    #     end
    #   end
    #   # stacked_data_to_display.push(month_hash)
    # end
    # {key:location_id, values:[{month:credits_sold}]}
    # data_to_display = {yAxisTitle: "Credits Sold By Month", chartData:stacked_data_to_display, chartType: "stacked"};
  end

  def dispensed_by_pump_by_month
    #Query for Stacked Bar Chart
    month_by_pump_total_obj_arr = Transaction.select("location_id, sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 1").group("extract(month from transaction_time),location_id")
    stacked_data_to_display = []
    labels_array = []
    (Date.today.month-5..Date.today.month).each do |month|
      month_hash = {}
      month_hash[:month] = month
      if month_by_pump_total_obj_arr.select{|obj| obj.month == month }.length > 0
        month_by_pump_total_obj_arr.select{|obj| obj.month == month }.sort.each do |obj|
          location_key = "location_id".concat(obj.location_id.to_s).to_sym
          month_hash[location_key] = obj.total
          labels_array.push(location_key)
        end
      end
      stacked_data_to_display.push(month_hash)
    end
    data_to_display = {xAxisTitle: "Month", yAxisTitle: "Liters of Water Dispensed By Month", chartData: stacked_data_to_display, chartType: "stacked", xKey:"month" , yKeys: labels_array.uniq};
    return data_to_display
  end


  def credits_by_kiosk_for_all
    chart_data_array = []
    #Query for Bar Chart and Table
    kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 20 or transaction_code = 21").group("location_id").order("sum(amount)")
    #Prepare data for Normalchart
    kiosk_total_obj_arr.each do |obj|
      chart_data_array.push({label: "location id " + obj.location_id.to_s, value: obj.total})
    end
    #Create json chart obj
    data_to_display = {yAxisTitle: "Credits Sold Per Kiosk", chartData: [{key:"Credits sold", values: chart_data_array}], chartType: "bar"};
    return data_to_display
  end

  def credits_by_kiosk_for_provider(provider)
    chart_data_array = []
    #Query for Bar Chart and Table
    kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 20 or transaction_code = 21").group("location_id").order("sum(amount)").limit(10)
    kiosk_total_obj_arr.each do |obj|
      if provider.kiosks.select{|kiosk| obj.location_id == kiosk.location_id }.length > 0
        chart_data_array.push({location_id: obj.location_id, total: obj.total})
      end
    end
    #Create json chart obj
    data_to_display = {xAxisTitle:"Kiosk Location Id", yAxisTitle:"Credits Sold", chartData: chart_data_array, chartType:"bar", xKey:"location_id", yKey:"total"};
    return data_to_display
  end

  def credits_by_month(kiosk)
    #Query db
    sold_by_month = Transaction.select("sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 20 and transaction_code = 21 and location_id = #{kiosk.location_id}").group("extract(month from transaction_time)")
    #Prepare data
    chart_data_array = []
    (Date.today.month-5..Date.today.month).each do |month|
      if sold_by_month.select{|obj| obj.month == month}.length > 0
        sold_in_month = sold_by_month.select{|obj| obj.month == month}[0].total
        chart_data_array.push({month: month, total: sold_in_month})
      else
        chart_data_array.push({month: month, total: 0})
      end
    end
    #Create json chart obj
    data_to_display = { xAxisTitle: "Month", yAxisTitle: "Credits Sold", chartData: chart_data_array, chartType: "bar", xKey:"month" , yKey: "total"};
    return data_to_display
  end

  #WATER DISPENSED
  def dispensed_by_pump_for_all_table
    chart_data_array = []
    #Query for Bar Chart and Table
    pump_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 1").group("location_id").order("sum(amount)")
    #Prepare data for Normalchart
    pump_total_obj_arr.each do |obj|
      chart_data_array.push({label: "location id "+ obj.location_id.to_s, value: obj.total})
    end
    { yAxisTitle: "Liters of Waters Dispensed Per Pump", chartData: [{key:"Liters of Water Dispensed" , values: chart_data_array}], chartType: "bar"};
  end

  def dispensed_by_pump_for_provider(provider)
    chart_data_array = []
    #Query for Bar Chart and Table
    pump_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 1").group("location_id").order("sum(amount)").limit(10)
    pump_total_obj_arr.each do |obj|
      if provider.pumps.select{|pump| obj.location_id == pump.location_id }.length > 0
        chart_data_array.push({location_id: obj.location_id, total: obj.total})
      end
    end
    #Create json chart obj
    data_to_display = {xAxisTitle:"Pump Location Id", yAxisTitle:"Credits Sold Per Kiosk", chartData: chart_data_array, chartType:"bar", xKey:"location_id", yKey:"total"};
    return data_to_display
  end

  def dispensed_by_month(pump)
    #Query db
    dispensed_by_month = Transaction.select("sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 1 and location_id = #{pump.location_id}").group("extract(month from transaction_time)")
    #Prepare data
    chart_data_array = []
    (Date.today.month-5..Date.today.month).each do |month|
      if dispensed_by_month.select{|obj| obj.month == month}.length > 0
        pumped_in_month = dispensed_by_month.select{|obj| obj.month == month}[0].total
        chart_data_array.push({month: month, total: pumped_in_month})
      else
        chart_data_array.push({month: month, total: 0})
      end
    end
    #Create json chart obj
    data_to_display = { xAxisTitle: "Month", yAxisTitle: "Water Dispensed", chartData: chart_data_array, chartType: "bar", xKey:"month" , yKey: "total"};
    return data_to_display
  end

  #CREDITS BOUGHT BY KIOSK
  def credits_bought_by_kiosk
    #Query db
    credits_init = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 23").group("location_id")
    credits_other = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 22 and ((starting_credits - ending_credits) < 0)").group("location_id")
    #Prepare data
    chart_data_array = []
    totals_hash = {}
    credits_init.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] = obj.total
    end
    credits_other.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] += obj.total
    end
    totals_hash.each {|location_id,total|
      chart_data_array.push({location_id: location_id, total: total})
    }
    #Create json chart obj
    data_to_display = { xAxisTitle: "Kiosk Location Id", yAxisTitle: "Credits Bought", chartData: chart_data_array, chartType: "bar", xKey:"kiosk" , yKey:"total"};
    return data_to_display
  end

  def credits_bought_by_kiosk_table
  #Query db
    credits_init = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 23").group("location_id")
    credits_other = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 22 and ((starting_credits - ending_credits) < 0)").group("location_id")
    #Prepare data
    chart_data_array = []
    totals_hash = {}
    credits_init.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] = obj.total
    end
    credits_other.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] += obj.total
    end
    totals_hash.each {|location_id,total|
      chart_data_array.push({location_id: location_id, total: total})
    }
    return chart_data_array
  end

  def credits_remaining_by_kiosk
    #Query db
    credits_init = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 23").group("location_id")
    credits_subtract = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 22 and ((starting_credits - ending_credits) > 0)").group("location_id")
    #Prepare data
    chart_data_array = []
    totals_hash = {}
    credits_init.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] = obj.total
    end
    credits_subtract.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] -= obj.total
    end
    totals_hash.each {|location_id,total|
      chart_data_array.push({location_id: location_id, total: total})
    }
    #Create json chart obj
    data_to_display = { xAxisTitle: "Kiosk Location Id", yAxisTitle: "Credits Remaining", chartData: chart_data_array, chartType: "bar", xKey:"kiosk" , yKey:"total"};
    return data_to_display
  end


  def credits_remaining_by_kiosk_table
    #Query db
    credits_init = Transaction.select("location_id, sum(amount) as total, max(transaction_time) as date").where("transaction_code = 23").group("location_id")
    credits_subtract = Transaction.select("location_id, sum(amount) as total, max(transaction_time) as date").where("transaction_code = 22 and ((starting_credits - ending_credits) > 0)").group("location_id")
    #Prepare data
    chart_data_array = []
    totals_hash = {}
    date_hash = {}
    credits_init.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] = obj.total
      date_hash[obj.location_id.to_s.to_sym] = obj.date.strftime('%b %d, %Y')
    end
    credits_subtract.each do |obj|
      totals_hash[obj.location_id.to_s.to_sym] -= obj.total
      if date_hash[obj.location_id.to_s.to_sym] < obj.date
        date_hash[obj.location_id.to_s.to_sym] = obj.date.strftime('%b %d, %Y')
      end
    end
    totals_hash.each {|location_id,total|
      chart_data_array.push({location_id: location_id, total: total, date: date_hash[location_id.to_s.to_sym]})
    }
    return chart_data_array
  end

  def sms_balance_by_pump
    chart_data_array = []
    sms_balance_by_location = Transaction.select("location_id, transaction_time as date, sum(amount) as total").where("transaction_code=41").group("location_id,transaction_time").order("transaction_time DESC")
    existing_ids = []
    sms_balance_by_location.each do |obj|
      if !existing_ids.include?(obj.location_id)
      chart_data_array.push({location_id: obj.location_id, date: obj.date, total: obj.total})
        existing_ids.push(obj.location_id)
      else
        existing_ids.push(obj.location_id)
      end
    end
    data_to_display = { xAxisTitle: "Pump Location Id", yAxisTitle: "SMS Balance", chartData: chart_data_array, chartType: "bar", xKey:"kiosk" , yKey:"total"};
    return data_to_display
  end


  def sms_balance_by_pump_table
    chart_data_array = []
    sms_balance_by_location = Transaction.select("location_id, transaction_time as date, sum(amount) as total").where("transaction_code=41").group("location_id,transaction_time").order("transaction_time DESC")
    existing_ids = []
    sms_balance_by_location.each do |obj|
      if !existing_ids.include?(obj.location_id)
      chart_data_array.push({location_id: obj.location_id, date: obj.date.strftime('%b %d, %Y'), total: obj.total})
        existing_ids.push(obj.location_id)
      else
        existing_ids.push(obj.location_id)
      end
    end
    return chart_data_array
  end

  def last_error_by_hub
    @gprs_errors_arr = []
    existing_ids = []
    gprs_errors = Transaction.select("location_id, transaction_time, count(amount) as count").where("transaction_code=39 AND amount =101 AND transaction_time > (Date.today - 30)").group("location_id").order("transaction_time")
    gprs_errors.each do |error|
      if !existing_ids.include?(obj.location_id)
        @gprs_errors_arr.push({location_id: error.location_id, error_type: "gprs" , count: error.count})
      else
        existing_ids.push(errror.location_id)
      end
    end
    @bat_low_errors_arr = []
    bat_low_errors = Transaction.select("location_id, transaction_time, count(amount) as count").where("transaction_code=39 AND amount =132 AND transaction_time > (Date.today - 30)").group("location_id")
    bat_low_errors.each do |error|
      @bat_low_errors_arr.push({location_id: error.location_id, error_type: "bat_low" , count: error.count})
    end
  end

  def errors_by_hub
    #Get array of all location ids
    location_ids = []
    Transaction.all.each do |transaction|
      location_ids.push(transaction.location_id)
    end
    location_ids.uniq!

    #Query db for given error by location
    gprs_errors = Transaction.select("location_id, count(amount) as count").where("transaction_code=39 AND amount=101").group("location_id")
    rfid_errors = Transaction.select("location_id, count(amount) as count").where("transaction_code=39 AND amount =111").group("location_id")
    bat_low_errors = Transaction.select("location_id, count(amount) as count").where("transaction_code=39 AND amount =132").group("location_id")
    bat_ok_errors = Transaction.select("location_id, count(amount) as count").where("transaction_code=39 AND amount =133").group("location_id")
    errors_hash = {}

    #Loop through all locations
    location_ids.each do |location_id|
      location_key_sym = ("location"+location_id.to_s).to_sym
      errors_hash[location_key_sym] = {}
      #Get gprs error count for given location
      gprs_errors.each do |error_obj|
        if error_obj.location_id == location_id
          errors_hash[location_key_sym][:gprs] = error_obj.count
        end
      end
      #Get gprs error count for given location
      gprs_errors.each do |error_obj|
        if error_obj.location_id == location_id
          errors_hash[location_key_sym][:gprs] = error_obj.count
        end
      end
      rfid_errors.each do |error_obj|
        if error_obj.location_id == location_id
          errors_hash[location_key_sym][:rfid] = error_obj.count
        end
      end
      bat_low_errors.each do |error_obj|
        if error_obj.location_id == location_id
          errors_hash[location_key_sym][:bat_low] = error_obj.count
        end
      end
      bat_ok_errors.each do |error_obj|
        if error_obj.location_id == location_id
          errors_hash[location_key_sym][:bat_ok] = error_obj.count
        end
      end
    end
    return errors_hash
  end

  def getHubs
    if admin_signed_in?
      kiosks = Kiosk.all
      pumps = Pump.all
    else
      kiosks = current_provider.kiosks
      pumps = current_provider.kiosks
    end
    {chartData: {kiosks: kiosks, pumps: pumps},
                  chartType: "map" }
  end

end
