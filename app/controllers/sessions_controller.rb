class SessionsController < ApplicationController

  def new
    if employee_signed_in?
      @provider = Provider.find(current_employee.provider_id)
      redirect_to provider_dashboard_path(@provider)
    elsif admin_signed_in?
      redirect_to current_admin
    else
      render 'employees/sessions/new'
    end
  end

end
