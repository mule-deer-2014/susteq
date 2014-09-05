feature 'User login' do
  background do
    admin = create(:admin)
  end

  scenario 'logs in an existing admin' do
    visit root_path
    fill_in 'Email', with: admin.email  
    fill_in 'Password', with: admin.password  
    click_link 'Log In'
  end
end
