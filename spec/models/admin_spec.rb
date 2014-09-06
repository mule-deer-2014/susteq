require_relative '../rails_helper'

describe Admin do
  #Tests that model has attributes
  it { should respond_to(:name) }
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

  describe "when password is not present" do
    before do
      @admin = Admin.new(name: "Example admin", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before do
      @admin = Admin.new(name: "Example admin", email: "user@example.com",
                       password: " ", password_confirmation: " ")
      @admin.password_confirmation = "mismatch"
    end

    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  before do
    @admin = Admin.create(name: "Example admin", email: "user@example.com",
                     password: "bob", password_confirmation: "bob")
  end
  let(:found_admin) { Admin.find_by(email: @admin.email) }

  describe "with valid password" do
    it { should eq found_admin.authenticate(@admin.password) }
  end

  describe "with invalid password" do
    let(:admin_for_invalid_password) { found_admin.authenticate("invalid") }

    it { should_not eq admin_for_invalid_password }
    specify { expect(admin_for_invalid_password).to be_false }
  end
end


end
