feature 'Provider adding an employee' do
  background do
    employee = create(:employee)
    visit root_path
    login(employee)
  end

  scenario 'can fill out form to create a new user' do
    click_link 'Manage Employee'
    click_link 'Add Employee'
    expect(current_path).to eq(new_employee_path)
    page.has_field?('email')
  end
end
