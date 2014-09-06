require 'rails_helper'

describe Admin::ProvidersController do
  before do
    @provider = FactoryGirl.create(:provider)
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
end
