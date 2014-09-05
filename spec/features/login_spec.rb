feature 'User login' do
  background do
    admin = FactoryGirl.create(:admin)
  end

  scenario 'logs in an existing admin' do
    visit admins_path
    fill_in 'Email', with: admin.email  
    fill_in 'Password', with: admin.password  
    click_link 'Log In'

    expect(current_path).to eq(admins_path)
    expect(page).to have_content(admin.first_name)
  end
end
