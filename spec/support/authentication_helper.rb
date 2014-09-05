module AuthenticationHelper
  def sign_in_admin
    admin = FactoryGirl.create(:admin)

    visit admins_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log In'

    return admin
  end

  def sign_in_wsp
    provider = FactoryGirl.create(:wsp)

    visit root_path
    fill_in 'Email', with: provider.email
    fill_in 'Password', with: provider.password
    click_button 'Log In'

    return provider
  end
end
