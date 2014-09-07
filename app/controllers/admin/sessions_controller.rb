class Admin::SessionsController < ApplicationController
  layout 'login'
  before_action :require_admin_signin, :only =>:destroy

  def new
    render 'admin/sessions/new'
  end

  def create
    @admin = Admin.find_by(email: params[:session][:email].downcase)
    if @admin && @admin.authenticate(params[:session][:password])
      admin_sign_in(@admin)
      redirect_to admin_dashboard_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'admin/sessions/new'
    end
  end

  def destroy
    admin_sign_out
    redirect_to '/admin'
  end
end
