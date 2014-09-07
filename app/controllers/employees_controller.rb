class EmployeesController < ApplicationController
  respond_to :html

  def index
    @employees = Employee.all
  end

  def create
    @employee = Employee.create(employee_params)
    redirect_to admin_employees_path
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(employee_params)
  end

  def destroy
    Employee.destroy(params[:id])
  end

  private

  def employee_params
    params.require(:employee).permit(:provider_id, :name, :email, :password_hash, :phone_number)
  end
end
