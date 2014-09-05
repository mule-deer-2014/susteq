require '../rails_helper'

describe User do
  it "has all attributes" do
    user = FactoryGirl.create(:user)
    expect(user.first_name.nil?).to eq(false)
    expect(user.last_name.nil?).to eq(false)
    expect(user.email.nil?).to eq(false)
    expect(user.password.nil?).to eq(false)
    expect(user.password_digest.nil?).to eq(false)
  end

end

