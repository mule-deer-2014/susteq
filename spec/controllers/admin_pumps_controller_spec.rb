require 'rails_helper'

describe Admin::PumpsController do
  before do
    admin = create(:admin)
    authorize_admin(admin)

    employee = create(:employee, :with_password)
    @pump = create(:pump)

    employee.provider.pumps << @pump
  end

  describe 'GET pumps#index' do
    before do
      get :index, format: "html"
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the index template when html is requested' do
      expect(response).to render_template("index")
    end

    it 'assigns @pumps' do
      expect(assigns(:pumps)).to eq([@pump])
    end
  end

  describe 'GET pumps#show' do
    before do
      get :show, id: @pump.id
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the show template' do
      expect(response).to render_template("show")
    end

    it 'assigns @pump' do
      expect(assigns(:pump)).to eq(@pump)
    end
  end
end
