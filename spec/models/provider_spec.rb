require_relative '../rails_helper'

describe Provider do
  #Tests that model has attributes
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:country) }
  it { should respond_to(:duns_number) }

  #Test associations
  it { should have_many(:pumps) }
  it { should have_many(:kiosks)}
  it { should have_many(:employees) }
end