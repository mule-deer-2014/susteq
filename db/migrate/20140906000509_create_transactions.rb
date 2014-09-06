class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :transaction_time
      t.integer :location_id
      t.decimal :longitude, {precision: 10, scale: 6}
      t.decimal :latitude, {precision: 10, scale: 6}
      t.integer :rfid_id
      t.integer :starting_credits
      t.integer :ending_credits
      t.string :transaction_type
      t.integer :amount
      t.string :error_code
      t.timestamps
    end
  end
end