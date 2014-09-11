require_relative 'seeds.rb'
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 21,
        location_id: 1,
        amount: 1
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 20,
        location_id: 1,
        amount: 2
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 20,
        location_id: 1,
        amount: 2
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 21,
        location_id: 2,
        amount: 3
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 20,
        location_id: 2,
        amount: 4
      )

      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 23,
        location_id: 1,
        amount: 1
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 23,
        location_id: 1,
        amount: 2
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 23,
        location_id: 1,
        amount: 2
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 20,
        location_id: 2,
        amount: 3
      )
      Transaction.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 20,
        location_id: 2,
        amount: 4
      )
