feature 'Employee logging in' do
  let (:admin) {FactoryGirl.create(:admin)}
  let(:employee) {FactoryGirl.create(:employee)}

  scenario 'with invalid email sees login error on login page' do
    visit root_path
    fill_in 'session[email]', with: 'invalidemail@'
    fill_in 'session[password]', with: employee.password
    find('input[type="submit"]').click

    expect(current_path).to eq(employee_signin_path)
    page.has_text?("Invalid")
  end

  scenario 'with invalid password sees login error on login page' do
    visit admin_signin_path
    fill_in 'session[email]', with: admin.email
    fill_in 'session[password]', with: '_asdfgfsasdf;'
    find('input[type="submit"]').click

    expect(current_path).to eq(admin_signin_path)
    page.has_text?("Invalid")
  end

  scenario 'as employee sees employee dashboard' do
    visit root_path
    login(employee)

    expect(current_path).to eq(provider_dashboard_path(employee.provider_id))
    expect(page).to have_content("Dashboard")
  end

  scenario 'as admin sees admin dashboard' do
    visit admin_signin_path
    login(admin)

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Dashboard")
  end
end
