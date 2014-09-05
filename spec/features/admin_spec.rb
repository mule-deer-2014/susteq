feature 'Admin' do
  background do
    admin = sign_in_admin
  end

  scenario 'can view all service providers' do
    providers = WSP.all
    click_link 'All Providers'
    
    expect(current_path).to eq(wsps_path)
    expect(page).to have_content(providers.last.first_name)
  end

  scenario 'can view all hubs' do
    hubs = Hub.all
    click_link 'All Hubs'
    
    expect(current_path).to eq(hubs_path)
    expect(page).to have_content(hubs.last.latitude)
  end
end
