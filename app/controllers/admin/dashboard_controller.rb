class Admin::DashboardController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def index
  end
end
