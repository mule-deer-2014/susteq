feature 'User logs in' do
  background do
    admin = FactoryGirl.create(:admin)
    provider = FactoryGirl.create(:wsp)
  end

  scenario 'provider sees wsp dashboard' do
    visit root_path
    fill_in 'Email', with: provider.email
    fill_in 'Password', with: provider.password
    click_link 'Log In'

    expect(current_path).to eq(wsps_path(provider.id))
    expect(page).to have_content(provider.first_name)
  end

  scenario 'admin sees admin dashboard' do
    visit admins_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_link 'Log In'

    expect(current_path).to eq(admins_path(admin.id))
    expect(page).to have_content(admin.first_name)
  end

  scenario 'login error displays on login page with invalid email' do
    visit root_path
    fill_in 'Email', with: 'invalidemail'
    fill_in 'Password', with: provider.password
    click_link 'Log In'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("ERROR")
  end

  scenario 'login error displays on login page with invalid password' do
    visit admins_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: '_asdfgfsasdf;'
    click_link 'Log In'

    expect(current_path).to eq(admins_path)
    expect(page).to have_content("ERROR")
  end
end
