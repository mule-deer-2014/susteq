module SessionsHelper
  def sign_in(employee)
    remember_token = Employee.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    employee.update_attribute(:remember_token, Employee.digest(remember_token))
    self.current_employee = employee
  end

  def signed_in?
    !current_employee.nil?
  end

  def current_employee=(employee)
    @current_employee = employee
  end

  def current_employee
    remember_token = Employee.digest(cookies[:remember_token])
    @current_employee ||= Employee.find_by(remember_token: remember_token)
  end

  def sign_out
    current_employee.update_attribute(:remember_token, Employee.digest(Employee.new_remember_token))
    cookies.delete(:remember_token)
    self.current_employee = nil
  end
end
