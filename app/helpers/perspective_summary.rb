module PerspectiveSummary

  #HELPER METHODS
  def getMonthName(month_number)
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    months[month_number-1]
  end

  def last_five_months
    (Date.today.month-5..Date.today.month).to_a.join(", ")
  end

  def provider_kiosk_locations_id(provider)
    provider.kiosks.map(&:location_id).join(",")
  end

  #CREDITS SOLD
  def credits_by_kiosk_for_all_table
    #Query for Bar Chart and Table
    kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 20 or transaction_code = 21").group("location_id").order("sum(amount)")
    #Prepare data for Normalchart
    chart_data_array = kiosk_total_obj_arr.map do |obj|
      chart_data_array.push({location_id: obj.location_id, total: obj.total})
    end
    return chart_data_array
  end

  def credits_by_kiosk_by_month
    #Query for Stacked Bar Chart
    total_credits_by_kiosk_by_month = Transaction.select("location_id, sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code in (20, 21) AND extract(month from transaction_time) IN (#{last_five_months})").group("extract(month from transaction_time),location_id")
    kiosk_location_array = total_credits_by_kiosk_by_month.map{ |obj| obj.location_id}.uniq.sort
    stacked_data = kiosk_location_array.map do |kiosk_id|
      transactions = total_credits_by_kiosk_by_month.select{|obj| obj.location_id == kiosk_id }
      values = (Date.today.month-5..Date.today.month).map do |month|
        if transaction = transactions.find{|transaction| transaction.month == month}
          {x: getMonthName(month), y:transaction.total}
        else
          {x: getMonthName(month), y:0}
        end
      end
      {key: "Kiosk Location Id #{kiosk_id}", values: values}
    end
    data_to_display = {yAxisTitle: "Credits Sold By Month", chartData:stacked_data, chartType: "stacked"};
  end

  def dispensed_by_pump_by_month
    #Query for Stacked Bar Chart
    month_by_pump_total_obj_arr = Transaction.select("location_id, sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 1").group("extract(month from transaction_time),location_id")
    months_array = (Date.today.month-5..Date.today.month).to_a
    stacked_data_to_display = []

    pump_location_array = month_by_pump_total_obj_arr.map{ |obj| obj.location_id}.uniq.sort
    stacked_data_to_display = pump_location_array.map do |pump_id|
      values = month_by_pump_total_obj_arr.select{|obj| obj.location_id == pump_id }
      values = months_array.map do |month|
        if values.any?{|obj| obj.month == month}
          obj = values.find{|obj| obj.month == month}
          {x: getMonthName(obj.month), y:obj.total}
        else
          {x: getMonthName(month), y:0}
        end
      end
      {key: "Pump Location Id #{pump_id}", values: values}
    end
    data_to_display = {yAxisTitle: "Litres of Water Dispensed Per Month", chartData:stacked_data_to_display, chartType: "stacked"};
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
    data_to_display = {yAxisTitle: "Credits Sold Per Kiosk", chartData: [{values: chart_data_array}], chartType: "bar"};
    return data_to_display
  end

  def credits_by_kiosk_for_provider(provider)
    chart_data_array = []
    #Query for Bar Chart and Table
    kiosk_total_obj_arr = Transaction.select("location_id, sum(amount) AS total").where("transaction_code IN (20,21) AND location_id IN (#{provider_kiosk_locations_id(provider)})").group("location_id").order("total")
    kiosk_total_obj_arr.each do |obj|
      chart_data_array.push({label:"location id " + obj.location_id.to_s, value:obj.total})
    end
    #Create json chart obj
    data_to_display = {yAxisTitle:"Credits Sold per Kiosk (past five months)", chartData:[{values: chart_data_array}], chartType:"bar"};
    return data_to_display
  end

  def credits_by_month(kiosk)
    #Query db
    sold_by_month = Transaction.select("sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code IN (20,21) AND location_id = #{kiosk.location_id} AND extract(month from transaction_time) IN (#{last_five_months})").group("extract(month from transaction_time)")
    p sold_by_month
    #Prepare data
    chart_data_array = sold_by_month.map do |transaction|
      if transaction.total > 0
        {label: getMonthName(transaction.month), value: transaction.total}
      else
        {label: getMonthName(transaction.month), value: 0}
      end
    end
    #Create json chart obj
    data_to_display = {yAxisTitle: "Credits Bought and Sold by Month", chartData:[{key:"Credits Bought and Sold by Month", values:chart_data_array}], chartType: "bar"};
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
    #Query for Bar Chart and Table
    pump_total_obj_arr = Transaction.select("location_id, sum(amount) as total").where("transaction_code = 1 AND location_id in (provider_kiosk_locations_id(provider)) AND extract(month from transaction_time) IN (#{last_five_months})").group("location_id").order("sum(amount)")
    chart_data_array = pump_total_obj_arr.map do |transaction|
      if transaction.total > 0
        {label: "location id " + obj.location_id.to_s, value: obj.total}
      else
        {label: "location id " + obj.location_id.to_s, value: 0}
      end
    end
    #Create json chart obj
    data_to_display = {yAxisTitle:"Liters of Water Dispensed", chartData: [{values:chart_data_array}], chartType:"bar"};
    return data_to_display
  end

  def dispensed_by_month(pump)
    #Query db
    dispensed_by_month = Transaction.select("sum(amount) as total,extract(month from transaction_time) as month").where("transaction_code = 1 AND location_id = #{pump.location_id} AND extract(month from transaction_time) IN (#{last_five_months})").group("extract(month from transaction_time)")
    #Prepare data
    dispensed_by_month = dispensed_by_month.sort_by(&:month)
    chart_data_array = dispensed_by_month.map do |transaction|
      if transaction.total > 0
        {label: getMonthName(transaction.month), value: transaction.total}
      else
        {label: getMonthName(transaction.month), value: 0}
      end
    end
    #Create json chart obj
    data_to_display = { yAxisTitle: "Water Dispensed per Month", chartData:[{key:"Liters of Water Dispensed Per Month", values: chart_data_array}], chartType: "bar"};
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
