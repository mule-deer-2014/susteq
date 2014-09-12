class Admin::EmployeesController < ApplicationController
  layout "admin_application"
  respond_to :html
  before_filter :require_admin_signin

  def index
    @viz_data = 0
    @providers = Provider.all
  end

  def create
    if params[:provider_id]
      begin
      @provider = Provider.find(params[:provider_id])
      @employee = Employee.create!(employee_params)
      redirect_to admin_provider_path(@provider)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_provider_employee_path(@provider)
      end
    else
      begin
      @employee = Employee.create!(employee_params)
      redirect_to admin_employees_path
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_employee_path
      end
    end
  end

  def new
    @viz_data = 0
    @employee = Employee.new
    @provider = Provider.find(params[:provider_id]) if params[:provider_id]
  end

  def edit
    @viz_data = 0
    @employee = Employee.find(params[:id])
    @provider = Provider.find(params[:provider_id]) if params[:provider_id]
  end

  def show
    @viz_data = 0
    @employee = Employee.find(params[:id])
  end

  def update #MLM NOTES TO REFACTOR - Need different way to redirect user when approach from nested provider route vs top level employee route
    employee = Employee.find(params[:id])
    if params[:provider_id]
      @provider = Provider.find(params[:provider_id])
      if employee.update(employee_params)
        redirect_to admin_provider_path(@provider)
      elsif employee_params.fetch(:password, []).empty?
        employee.update_attribute(:provider_id, employee_params[:provider_id])
        employee.update_attribute(:name, employee_params[:name])
        employee.update_attribute(:email, employee_params[:email])
        employee.update_attribute(:phone_number, employee_params[:phone_number])
        redirect_to admin_provider_path(@provider)
      else
        begin
        employee.update!(employee_params)
        rescue ActiveRecord::RecordInvalid => invalid
          flash[:error_messages] = invalid.record.errors.full_messages
          redirect_to edit_admin_provider_employee_path(provider,employee)
        end
      end
    else
      if employee.update(employee_params)
        redirect_to admin_employees_path
      elsif employee_params.fetch(:password, []).empty?
        employee.update_attribute(:provider_id, employee_params[:provider_id])
        employee.update_attribute(:name, employee_params[:name])
        employee.update_attribute(:email, employee_params[:email])
        employee.update_attribute(:phone_number, employee_params[:phone_number])
        redirect_to admin_employees_path
      else
        begin
        employee.update!(employee_params)
        rescue ActiveRecord::RecordInvalid => invalid
          flash[:error_messages] = invalid.record.errors.full_messages
          redirect_to edit_admin_employee_path(employee)
        end
      end
    end
  end

  def destroy
    Employee.destroy(params[:id])
    if params[:provider_id]
      @provider = Provider.find(params[:provider_id])
      redirect_to admin_provider_path(@provider)
    else
      redirect_to admin_employees_path
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:provider_id, :name, :email, :password, :password_digest, :phone_number)
  end
end
