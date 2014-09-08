module ApplicationHelper
  def employee_sign_in(employee)
    remember_token = Employee.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    employee.update_attribute(:remember_token, Employee.digest(remember_token))
    self.current_employee = employee
  end

  def employee_signed_in?
    !current_employee.nil?
  end

  def current_employee=(employee)
    @current_employee = employee
  end

  def current_employee
    remember_token = Employee.digest(cookies[:remember_token])
    @current_employee ||= Employee.find_by(remember_token: remember_token)
  end

  def current_provider
    @current_provider = current_employee.provider
  end

  def employee_sign_out
    current_employee.update_attribute(:remember_token, Employee.digest(Employee.new_remember_token))
    cookies.delete(:remember_token)
    self.current_employee = nil
  end

  def require_employee_signin
    unless employee_signed_in?
      redirect_to root_path
    end
  end


  def admin_sign_in(admin)
    remember_token = Admin.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    admin.update_attribute(:remember_token, Admin.digest(remember_token))
    self.current_admin = admin
  end

  def admin_signed_in?
    !current_admin.nil?
  end

  def current_admin=(admin)
    @current_admin = admin
  end

  def current_admin
    remember_token = Admin.digest(cookies[:remember_token])
    @current_admin ||= Admin.find_by(remember_token: remember_token)
  end

  def admin_sign_out
    current_admin.update_attribute(:remember_token, Admin.digest(Admin.new_remember_token))
    cookies.delete(:remember_token)
    self.current_admin = nil
  end

  def require_admin_signin
    unless admin_signed_in?
      redirect_to '/admin'
    end
  end
end
