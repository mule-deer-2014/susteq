describe User do
  it "should respond to all of its attributes" do
    before do
      @user = User.new(first_name: "ExFirst", last_name: "ExLast", email: "user@example.com")
    end

    subject { @user }
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
  end
end
