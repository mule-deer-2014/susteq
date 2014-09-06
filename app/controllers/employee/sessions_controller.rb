
class Employee::SessionsController < ApplicationController

  def new
    render 'employee/sessions/new'
  end

  def create
    @employee = Employee.find_by(email: params[:session][:email].downcase)
    @provider = Provider.find(@employee.provider_id)
    if @employee && @employee.authenticate(params[:session][:password])
      employee_sign_in(@employee)
      redirect to @provider
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'employee/sessions/new'
    end
  end

  def destroy
    employee_sign_out
    redirect_to root_url
  end
end
