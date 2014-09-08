require_relative '../rails_helper'

describe Pump do
  #Tests that model has attributes
  it { should respond_to(:name) }
  it { should respond_to(:location_id) }
  it { should respond_to(:type) }
  it { should respond_to(:provider_id) }
  it { should respond_to(:longitude) }
  it { should respond_to(:latitude) }

  #Test associations
  it { should belong_to (:provider) }
  it { should have_many (:transactions) }
end