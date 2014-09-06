
class Admin::SessionsController < ApplicationController

  #root '/' -> Renders new.html.erb which is login form
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      sessions[:remember_token] = @user.id
      redirect_to @user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end

class Provider::SessionsController < ApplicationController

  #root '/' -> Renders new.html.erb which is login form
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      sessions[:remember_token] = @user.id
      redirect_to @user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
