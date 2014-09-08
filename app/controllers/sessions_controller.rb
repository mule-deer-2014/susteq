class SessionsController < ApplicationController
  layout "login"

  def new
    if employee_signed_in?
      @provider = Provider.find(current_employee.provider_id)
      redirect_to provider_dashboard_path
    elsif admin_signed_in?
      redirect_to admin_dashboard_path
    else
      redirect_to employee_signin_path
    end
  end
end
