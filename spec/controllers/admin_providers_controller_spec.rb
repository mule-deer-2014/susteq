require 'rails_helper'

describe Admin::ProvidersController do
  before do
    @admin = FactoryGirl.create(:admin)
    @provider = FactoryGirl.create(:provider)
    authorize_admin(@admin)
  end

  describe 'Response statuses' do
    describe 'GET providers#index' do
      it 'returns a successful status' do
        get :index
        assert_response :success
      end
    end

    describe 'GET providers#new' do
      it 'returns a successful status' do
        get :new
        assert_response :success
      end
    end

    describe 'GET providers#edit' do
      it 'returns a successful status' do
        get :edit, {id: @provider.id}
        assert_response :success
      end
    end

    describe 'GET providers#show' do
      it 'returns a successful status' do
        get :show, {id: @provider.id}
        assert_response :success
      end
    end
  end

  describe 'POST providers#create' do
    it 'creates a new provider' do
      expect {
        post :create, provider: FactoryGirl.attributes_for(:provider)
      }.to change(Provider, :count)
    end
    
    it 'redirects to list of providers' do
      post :create, provider: FactoryGirl.attributes_for(:provider)
      assert_redirected_to admin_providers_path
    end
  end
end
