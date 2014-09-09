class EmployeesController < ApplicationController
  layout "provider_application"
  respond_to :html
  before_filter :require_employee_signin

  def index
    @employees = current_provider.employees.all
  end

  def create
    @employee = current_provider.employees.create!(employee_params)
    redirect_to employees_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_employee_path
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    employee = Employee.find(params[:id])

    if employee.update(employee_params)
      redirect_to employees_path
    elsif employee_params.fetch(:password, []).empty?
      employee.update_attribute(:name, employee_params[:name])
      employee.update_attribute(:email, employee_params[:email])
      employee.update_attribute(:phone_number, employee_params[:phone_number])
      redirect_to employees_path
    else
      begin
      employee.update!(employee_params)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to edit_employee_path(employee)
      end
    end
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
    if current_employee.update_attributes(employee_params) #if entered new password, then do this way
      redirect_to current_employee_path
    elsif employee_params[:password].empty? #if entered blank password, then do this way
      current_employee.update_attribute(:name, employee_params[:name])
      current_employee.update_attribute(:email, employee_params[:email])
      current_employee.update_attribute(:phone_number, employee_params[:phone_number])
      redirect_to current_employee_path
    else #if failed for some other reason, redirect to edit form
      begin
      current_employee.update!(employee_params)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to edit_current_employee_path
      end
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:provider_id, :name, :email, :remember_token, :password, :password_confirmation, :phone_number)
  end
end
