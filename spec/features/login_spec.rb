feature 'User logging in' do
  background do
    admin = FactoryGirl.create(:admin)
    provider = FactoryGirl.create(:wsp)
  end

  scenario 'with invalid email sees login error on login page' do
    visit root_path
    fill_in 'email', with: 'invalidemail'
    fill_in 'password', with: provider.password
    click_button 'Sign in'

    expect(current_path).to eq(root_path)
    page.has_text?("ERROR")
  end

  scenario 'with invalid password sees login error on login page' do
    visit admins_path
    fill_in 'email', with: admin.email
    fill_in 'password', with: '_asdfgfsasdf;'
    click_link 'Sign in'

    expect(current_path).to eq(admins_path)
    page.has_text?("ERROR")
  end

  scenario 'as provider sees wsp dashboard' do
    visit root_path
    login(provider)

    expect(current_path).to eq(wsps_path(provider.id))
    expect(page).to have_content(provider.first_name)
  end

  scenario 'as admin sees admin dashboard' do
    visit admins_path
    login(admin)

    expect(current_path).to eq(admins_path(admin.id))
    expect(page).to have_content(admin.first_name)
  end
end
