require 'rails_helper'

describe Admin::SessionsController do
  describe 'GET sessions#new' do
    context 'signed in' do
      it 'redirects to admin dashboard' do
        admin = create(:admin)
        authorize_admin(admin)
        get :new
        assert_redirected_to admin_dashboard_path
      end
    end

    context 'signed out' do
      it 'redirects to sign in page' do
        get :new
        assert_template('admin/sessions/new')
      end
    end
  end
end
