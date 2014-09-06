module Admin
  class ProvidersController < ApplicationController
    respond_to :html

    def index
      @providers = Provider.all
    end

    def create
      @provider = Provider.create(provider_params)
    end

    def new
      @provider = Provider.new
    end

    def edit
      @provider = Provider.find(params[:id])
    end

    def show
      @provider = Provider.find(params[:id])
    end

    def update
      @provider = Provider.find(params[:id])
      @provider.update(provider_params)
    end

    def destroy
      Provider.destroy(params[:id])
    end

    private

    def provider_params
      params.require(:provider).permit(:first_name, :last_name, :email, :password_hash)
    end
  end
end
