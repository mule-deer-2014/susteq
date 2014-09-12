class Admin::SessionsController < ApplicationController
  layout 'login'
  before_action :require_admin_signin, :only =>:destroy

  def new
    @viz_data = 0
    if admin_signed_in?
      redirect_to admin_dashboard_path
    else
      render 'admin/sessions/new'
    end
  end

  def create
    @admin = Admin.find_by(email: params[:session][:email].downcase)
    if @admin && @admin.authenticate(params[:session][:password])
      admin_sign_in(@admin)
      redirect_to admin_dashboard_path
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to admin_signin_path
    end
  end

  def destroy
    admin_sign_out
    redirect_to admin_signin_path
  end
end
