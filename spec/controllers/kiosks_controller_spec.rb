require 'rails_helper'

describe KiosksController do
  before do
    employee = create(:employee, :with_password)
    @kiosk = create(:kiosk)
    authorize_employee(employee)
    employee.provider.kiosks << @kiosk
  end

  describe 'Response status' do
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
end
