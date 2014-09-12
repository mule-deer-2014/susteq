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

    describe 'GET sessions#new' do
      it 'redirects to employee signin' do
        get :new
        assert_redirected_to provider_dashboard_path
      end
    end
  end
end
