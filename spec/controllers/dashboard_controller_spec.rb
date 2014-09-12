require 'rails_helper'

describe DashboardController do
  before do
    @employee = create(:employee, :with_password)
    authorize_employee(@employee)
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
      expect(response).to render_template("dashboard/main")
    end
<<<<<<< HEAD
<<<<<<< HEAD

    it 'assigns @hubs' do
      expect(assigns(:hubs)).to eq(provider.hubs)
    end
=======
>>>>>>> origin/new-in-process-master
=======
>>>>>>> fbe091f6e388a75dd803ca2338f5aaabbbbaa4f2
  end
end
