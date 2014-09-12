class Employee::SessionsController < ApplicationController
  layout 'login'
  before_action :require_employee_signin, :only =>:destroy
  def new
    @viz_data = 0
    render 'employees/sessions/new'
  end

  def create
    @employee = Employee.find_by(email: params[:session][:email].downcase)
    if @employee && @employee.authenticate(params[:session][:password])
      @provider = Provider.find(@employee.provider_id)
      employee_sign_in(@employee)
      redirect_to provider_dashboard_path(@provider)
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to employee_signin_path
    end
  end

  def destroy
    employee_sign_out
    redirect_to root_url
  end
end
