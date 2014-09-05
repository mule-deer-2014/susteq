feature 'Admin' do
  background do
    admin = FactoryGirl.create(:admin)
    visit admins_path
    login(admin)
  end

  scenario 'can view all service providers' do
    providers = WSP.all
    click_link 'All Providers'
    
    expect(current_path).to eq(wsps_path)
    expect(page).to have_content(providers.last.first_name)
  end

  scenario 'can view all kiosks' do
    kiosks = Kiosk.all
    click_link 'All Kiosks'
    
    expect(current_path).to eq(kiosks_path)
    expect(page).to have_content(kiosks.last.latitude)
  end
end
