require 'rails_helper'

describe Admin::ProvidersController do
  before do
    @admin = create(:admin)
    @provider = create(:provider)
    authorize_admin(@admin)
  end

  describe 'Response status' do
    describe 'GET providers#index' do
      before do
        get :index
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the index template' do
        expect(response).to render_template("index")
      end

      it "assigns @providers" do
        expect(assigns(:providers)).to eq([@provider])
      end
    end

    describe 'GET providers#new' do
      before do
        get :new
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the new template' do
        expect(response).to render_template("new")
      end

      it "assigns @provider as a new object" do
        expect(assigns(:provider)).to be_new_record
      end
    end

    describe 'GET providers#edit' do
      before do
        get :edit, {id: @provider.id}
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the edit template' do
        expect(response).to render_template("edit")
      end

      it "assigns @provider" do
        expect(assigns(:provider)).to eq(@provider)
      end
    end

    describe 'GET providers#show' do
      before do
        get :show, {id: @provider.id}
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the show template' do
        expect(response).to render_template("show")
      end

      it "assigns @provider" do
        expect(assigns(:provider)).to eq(@provider)
      end

      it "assigns @pumps" do
        expect(assigns(:pumps)).to eq(@provider.pumps)
      end

      it "assigns @kiosks" do
        expect(assigns(:kiosks)).to eq(@provider.kiosks)
      end

      it "assigns @employees" do
        expect(assigns(:employees)).to eq(@provider.employees)
      end
    end
  end

  describe 'POST providers#create' do
    context 'with valid provider info' do
      it 'creates a new provider' do
        expect {
          post :create, provider: attributes_for(:provider)
        }.to change(Provider, :count)
      end

      it 'redirects to list of providers' do
        post :create, provider: attributes_for(:provider)
        assert_redirected_to admin_providers_path
      end
    end

    context 'with invalid provider info' do
      it 'does not create a provider' do
        expect {
          post :create, provider: attributes_for(:provider, name: nil)
        }.to_not change(Provider, :count)
      end

      it 'redirects to new provider view' do
        post :create, provider: attributes_for(:provider, name: nil)
        assert_redirected_to new_admin_provider_path
      end
    end
  end

  describe 'PUT providers#update' do
    let(:updated_name) {Faker::Name.first_name}

    it 'updates provider attributes' do
      expect {
        put :update, id: @provider.id, provider: attributes_for(:provider, name: updated_name)
        @provider.reload
      }.to change(@provider, :name)
    end

    it 'redirects to list of providers' do
      put :update, id: @provider.id, provider: attributes_for(:provider, name: updated_name)
      assert_redirected_to admin_providers_path
    end
  end

  describe 'DELETE providers#destroy' do
    it 'removes provider from database' do
      expect {
        delete :destroy, id: @provider.id
      }.to change(Provider, :count)
    end

    it 'redirects to list of providers' do
      delete :destroy, id: @provider.id
      assert_redirected_to admin_providers_path
    end
  end
end
