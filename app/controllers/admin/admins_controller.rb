class Admin::AdminsController < ApplicationController
  layout "admin_application"

  def dashboard
    render 'admin/dashboard/dashboard'
  end
end
