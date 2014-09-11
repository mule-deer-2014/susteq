require 'rails_helper'

describe Admin::DashboardController do
  before do
    @admin = create(:admin)
    authorize_admin(@admin)
  end

  let(:provider) {@employee.provider}

  describe 'GET dashboard#main' do
    before do
      get :main
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the dashboard template' do
      expect(response).to render_template("admin/dashboard/main")
    end

    it 'assigns @new_hub_ids' do
    end
  end
end
