require 'rails_helper'

describe Admin::KiosksController do
  before do
    admin = create(:admin)
    authorize_admin(admin)

    employee = create(:employee, :with_password)
    @kiosk = create(:kiosk)

    employee.provider.kiosks << @kiosk
  end

  describe 'GET kiosks#index' do
    before do
      get :index, format: "html"
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the index template when html is requested' do
      expect(response).to render_template("index")
    end

    it 'assigns @kiosks' do
      expect(assigns(:kiosks)).to eq([@kiosk])
    end
  end

  describe 'GET kiosks#show' do
    before do
      get :show, id: @kiosk.id
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the show template' do
      expect(response).to render_template("show")
    end

    it 'assigns @kiosk' do
      expect(assigns(:kiosk)).to eq(@kiosk)
    end
  end
end
