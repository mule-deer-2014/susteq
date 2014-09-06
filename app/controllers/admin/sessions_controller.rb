
  class Admin::SessionsController < ApplicationController

    def new
    end

    def create
      @admin = Admin.find_by(email: params[:session][:email].downcase)
      if @admin && @admin.authenticate(params[:session][:password])
        sign_in(@admin)
        redirect_to @admin
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
