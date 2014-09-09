module AuthenticationHelper
  def login user
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    find('input[type="submit"]').click
  end

  def authorize_employee employee
    remember_token = Employee.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    employee.update_attribute(:remember_token, Employee.digest(remember_token))
    current_employee = employee
  end

  def authorize_admin admin
    remember_token = Admin.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    admin.update_attribute(:remember_token, Admin.digest(remember_token))
    current_admin = admin
  end
end
