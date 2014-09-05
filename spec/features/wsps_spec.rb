feature 'Water Service Provider adding a user' do
  background do
    provider = FactoryGirl.create(:wsp)
    visit root_path
    login(provider)
  end

  scenario 'can fill out form to create a new user' do
    click_link 'Add User' 
    expect(current_path).to eq(new_wsp_path)
    page.has_field?('email')
  end
end
