require_relative '../rails_helper'

describe Transaction do
  #Tests that model has attributes
  it { should respond_to(:transaction_time) }
  it { should respond_to(:location_id) }
  it { should respond_to(:longitude) }
  it { should respond_to(:latitude) }
  it { should respond_to(:rfid_id) }
  it { should respond_to(:starting_credits) }
  it { should respond_to(:ending_credits) }
  it { should respond_to(:transaction_code) }
  it { should respond_to(:amount) }
  it { should respond_to(:error_code) }


  #Test associations
  it { should belong_to(:transactable) }
end