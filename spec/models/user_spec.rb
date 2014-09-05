require '../rails_helper'

describe User, :type => :model do
  it "has all attributes" do
  @user = FactoryGirl.create(:user)
    expect(@user.first_name.nil?).to eq(false)
    expect(@user.last_name.nil?).to eq(false)
    expect(@user.email.nil?).to eq(false)
  end
end

