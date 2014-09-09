class Admin::AdminsController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def dashboard
    @new_hubs_ids = (Transaction.all - Hub.get_all_transactions).map { |transaction| transaction.location_id }
    render 'admin/dashboard/dashboard'
  end

  def index
    @admins = Admin.all
  end

  def create
    @admin = Admin.new(admin_params)
    redirect_to admin_admins_path and return if @admin.save
    redirect_to new_admin_path
  end

  def new
    @admin = Admin.new
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    admin = Admin.find(params[:id])

    if admin.update(admin_params)
      redirect_to admin_admins_path
    elsif admin_params.fetch(:password, []).empty?
      admin.update_attribute(:name, admin_params[:name])
      admin.update_attribute(:email, admin_params[:email])
      admin.update_attribute(:phone_number, admin_params[:phone_number])
      redirect_to admin_admins_path
    else
      redirect_to edit_admin_admin_path(admin)
    end
  end

  def destroy
    Admin.destroy(params[:id])
    redirect_to admin_admins_path
  end

  def show_current
    render 'admin/admins/show_current'
  end

  def edit_current
    render 'admin/admins/edit_current' #can make this form unhide rather than new pg in non-MVP
  end

  def update_current
    if current_admin.update_attributes(admin_params) #if entered new password, then do this way
      redirect_to current_admin_path
    elsif admin_params[:password].empty? #if entered blank password, then do this way
      current_admin.update_attribute(:name, admin_params[:name])
      current_admin.update_attribute(:email, admin_params[:email])
      redirect_to current_admin_path
    else #if failed for some other reason, redirect to edit form
      redirect_to edit_current_admin_path
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_hash)
  end
end
