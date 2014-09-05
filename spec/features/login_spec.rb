feature 'User logging in' do
  background do
    admin = FactoryGirl.create(:admin)
    provider = FactoryGirl.create(:wsp)
  end

  scenario 'with invalid email sees login error on login page' do
    visit root_path
    fill_in 'Email', with: 'invalidemail'
    fill_in 'Password', with: provider.password
    click_link 'Log In'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("ERROR")
  end

  scenario 'with invalid password sees login error on login page' do
    visit admins_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: '_asdfgfsasdf;'
    click_link 'Log In'

    expect(current_path).to eq(admins_path)
    expect(page).to have_content("ERROR")
  end

  scenario 'as provider sees wsp dashboard' do
    provider = sign_in_wsp

    expect(current_path).to eq(wsps_path(provider.id))
    expect(page).to have_content(provider.first_name)
  end

  scenario 'as admin sees admin dashboard' do
    admin = sign_in_admin

    expect(current_path).to eq(admins_path(admin.id))
    expect(page).to have_content(admin.first_name)
  end
end
