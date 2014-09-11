require 'csv'
file = "db/data_dump.csv"

# headers = [id, transaction_time, date,time, location_id, lattitude, longitude,rfid_id, starting_credits, ending_credits, transaction_type, amount, error_code]
CSV.foreach(file) do |csv_row|
  p csv_row
  Transaction.create(transaction_time:Time.at(csv_row[1].to_i),location_id:csv_row[4], latitude:csv_row[5], longitude:csv_row[6], rfid_id: csv_row[7], starting_credits:csv_row[8],ending_credits:csv_row[9], transaction_code:csv_row[10].to_i, amount:csv_row[11].to_i, error_code:csv_row[12])
end