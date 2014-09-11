require 'rails_helper'

describe SessionsController do
  context 'at site launch before signin' do
    describe 'GET sessions#new' do
      it 'redirects to employee signin' do
        get :new
        assert_redirected_to employee_signin_path
      end
    end
  end

  context 'as admin' do
    before do
      admin = create(:admin)
      authorize_admin(admin)
      get :index, format: 'json'
    end

    describe 'GET sessions#index' do
      it 'returns a successful status' do
        assert_response :success
      end

      it 'responds with valid json' do
        expect {
            JSON.parse(response.body)
          }.to_not raise_error
      end

      it 'responds with admin permissions' do
        get :index, format: 'json'
        expected_response = {permission: 'admin'}.to_json
        expect(response.body).to eq(expected_response)
      end
    end

    describe 'GET sessions#new' do
      it 'redirects to admin dashboard' do
        get :new
        assert_redirected_to admin_dashboard_path
      end
    end
  end

  context 'as employee' do
    before do
      @employee = create(:employee, :with_password)
      authorize_employee(@employee)
    end

    describe 'GET sessions#index' do
      it 'responds with employee permissions' do
        get :index, format: 'json'
        expected_response = {permission: @employee.provider.id}.to_json
        expect(response.body).to eq(expected_response)
      end
    end

    describe 'GET sessions#new' do
      it 'redirects to employee signin' do
        get :new
        assert_redirected_to provider_dashboard_path
      end
    end
  end
end
