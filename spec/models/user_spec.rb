require '../rails_helper'

describe User do
  #Tests that model has attributes
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }

  #Tests that has_secure_password rails method (that uses bcrypt) is working and encrypts password into digest
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

end

