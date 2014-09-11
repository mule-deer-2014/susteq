class EmployeesController < ApplicationController
  layout "provider_application"
  respond_to :html
  before_filter :require_employee_signin

  def index
    @viz_data = 0
    @employees = current_provider.employees.all
  end

  def create
    begin
      @employee = current_provider.employees.create!(employee_params)
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_employee_path and return
    end

    redirect_to employees_path
  end

  def new
    @viz_data = 0
    @employee = Employee.new
  end

  def edit
    @viz_data = 0
    @employee = Employee.find(params[:id])
  end

  def update
    employee = Employee.find(params[:id])

    begin
      employee.update!(employee_params)
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to edit_employee_path(employee) and return
    end

    redirect_to employees_path
  end

  def destroy
    Employee.destroy(params[:id])
    redirect_to employees_path
  end

  def show_current
    render 'employees/show_current'
  end

  def edit_current
    render 'employees/edit_current' #can make this form unhide rather than new pg in non-MVP
  end

  def update_current
    begin
      current_employee.update!(employee_params)
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to edit_current_employee_path and return
    end

    redirect_to current_employee_path
  end

  private

  def employee_params
    params.require(:employee).permit(:provider_id, :name, :email, :remember_token, :password, :password_confirmation, :phone_number)
  end
end
