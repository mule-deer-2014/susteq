feature 'Admin' do
  background do
    admin = FactoryGirl.create(:admin)
    visit admin_signin_path
    login(admin)
  end

  scenario 'can view all service providers' do
    provider = FactoryGirl.create(:provider)
    click_link 'Providers'
    
    expect(current_path).to eq(admin_providers_path)
    expect(page).to have_content(provider.name)
  end

  scenario 'can view all kiosks' do
    kiosk = FactoryGirl.create(:kiosk)
    click_link 'Kiosks'
    
    expect(current_path).to eq(admin_kiosks_path)
    expect(page).to have_content(kiosk.name)
  end
end
