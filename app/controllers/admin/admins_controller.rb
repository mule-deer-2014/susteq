class Admin::AdminsController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def dashboard
    render 'admin/dashboard/dashboard'
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
