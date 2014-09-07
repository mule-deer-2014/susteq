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

  end
end
