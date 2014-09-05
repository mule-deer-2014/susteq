feature 'Water Service Provider adding a user' do
  background do
    provider = sign_in_wsp
  end

  scenario 'can fill out form to create a new user' do
    click_link 'Add User' 
    expect(current_path).to eq(new_wsp_path)
    page.has_field?('email')
  end
end
