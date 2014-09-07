class Admin::AdminsController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def dashboard
    render 'admin/dashboard/dashboard'
  end
end

