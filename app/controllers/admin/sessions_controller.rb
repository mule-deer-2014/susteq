
class Admin::SessionsController < ApplicationController

  def new
    render 'admins/sessions/new'
  end

  def create
    @admin = Admin.find_by(email: params[:session][:email].downcase)
    if @admin && @admin.authenticate(params[:session][:password])
      admin_sign_in(@admin)
      redirect_to @admin
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'admins/sessions/new'
    end
  end

  def destroy
    admin_sign_out
    redirect_to '/admin'
  end

end
