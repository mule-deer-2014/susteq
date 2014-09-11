require 'rails_helper'

describe EmployeesController do
  before do
    @employee = create(:employee, :with_password)
    authorize_employee(@employee)
  end

  describe 'Response status' do
    describe 'GET employees#index' do
      before do
        get :index, provider_id: @employee.provider_id
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the index template' do
        expect(response).to render_template("index")
      end

      it 'assigns @employees' do
        expect(assigns(:employees)).to eq([@employee])
      end
    end

    describe 'GET employees#new' do
      before do
        get :new, provider_id: @employee.provider_id
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the new template' do
        expect(response).to render_template("new")
      end

      it 'assigns @employees' do
        expect(assigns(:employee)).to be_new_record
      end
    end

    describe 'GET employees#edit' do
      before do
        get :edit, {id: @employee.id, provider_id: @employee.provider_id}
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the edit template' do
        expect(response).to render_template("edit")
      end

      it 'assigns @employee' do
        expect(assigns(:employee)).to eq(@employee)
      end
    end

    describe 'GET employees#show_current' do
      before do
        get :show_current
      end

      it 'returns a successful status' do
        assert_response :success
      end

      it 'renders the show_current template' do
        expect(response).to render_template("show_current")
      end
    end
  end

  describe 'POST employees#create' do
    context 'with valid employee info' do
      it 'creates a new employee' do
        expect {
          post :create, employee: attributes_for(:employee, :with_password), provider_id: @employee.provider_id
        }.to change(Employee, :count)
      end

      it 'redirects to list of employees' do
        post :create, employee: attributes_for(:employee, :with_password), provider_id: @employee.provider_id
        assert_redirected_to employees_path
      end
    end

    context 'with invalid employee info' do
      it 'does not create a provider' do
        expect {
          post :create, employee: attributes_for(:employee, :with_password, name: nil), provider_id: @employee.provider_id
        }.to_not change(Employee, :count)
      end

      it 'redirects to new employee page' do
        post :create, employee: attributes_for(:employee, :with_password, name: nil), provider_id: @employee.provider_id
        assert_redirected_to new_employee_path
      end
    end
  end

  describe 'PUT providers#update' do
    let(:updated_name) {Faker::Name.first_name}
    let(:employee_no_password) do
      employee = create(:employee, password: 'password')
      Employee.find(employee.id)
    end

    context 'without password param' do
      it 'updates employee attributes' do
        expect {
          put :update, id: @employee.id, employee: attributes_for(:employee, :with_password, name: updated_name), provider_id: @employee.provider_id
          @employee.reload
        }.to change(@employee, :name)
      end

      it 'redirects to list of employees' do
        put :update, id: @employee.id, employee: attributes_for(:employee, :with_password, name: updated_name), provider_id: @employee.provider_id
        assert_redirected_to employees_path
      end
    end

    context 'without password param' do
      it 'updates employee attributes' do
        expect {
          put :update, id: employee_no_password.id, employee: attributes_for(:employee, name: updated_name), provider_id: employee_no_password.provider_id
          employee_no_password.reload
        }.to change(employee_no_password, :name)
      end

      it 'redirects to list of employees' do
        put :update, id: employee_no_password.id, employee: attributes_for(:employee, name: updated_name), provider_id: employee_no_password.provider_id
        assert_redirected_to employees_path
      end
    end
  end

  describe 'DELETE providers#destroy' do
    it 'removes employee from database' do
      expect {
        delete :destroy, id: @employee.id, provider_id: @employee.provider_id
      }.to change(Employee, :count)
    end

    it 'redirects to list of employees' do
      delete :destroy, id: @employee.id, provider_id: @employee.provider_id
      assert_redirected_to employees_path
    end
  end
end
