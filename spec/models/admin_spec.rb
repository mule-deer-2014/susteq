require_relative '../rails_helper'

describe Admin do
  #Tests that model has attributes
  it { should respond_to(:name) } # Be aware this would generally be called  "low-value" test as you're testing ActiveRecord.
  it { should respond_to(:email) }
  it { should respond_to(:provider_id) }
  it { should respond_to(:type) }
  it { should respond_to(:phone_number) }

  #Tests that has_secure_password rails method (that uses bcrypt) is working and encrypts password into digest
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

end
