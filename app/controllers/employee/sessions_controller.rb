class Employee::SessionsController < ApplicationController

  def new
  end

  def create
    @employee = Employee.find_by(email: params[:session][:email].downcase)
    @provider = Provider.find(@employee.provider_id)
    if @employee && @employee.authenticate(params[:session][:password])
      sign_in(@employee)
      redirect to @provider
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
