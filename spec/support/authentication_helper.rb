module AuthenticationHelper
  def sign_in_admin
    admin = FactoryGirl.create(:admin)

    visit admins_path
    fill_in 'email', with: admin.email
    fill_in 'password', with: admin.password
    click_button 'Sign in'

    return admin
  end

  def sign_in_wsp
    provider = FactoryGirl.create(:wsp)

    visit root_path
    fill_in 'email', with: provider.email
    fill_in 'password', with: provider.password
    click_button 'Sign in'

    return provider
  end
end
