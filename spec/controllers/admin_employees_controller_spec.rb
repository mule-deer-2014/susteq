require 'rails_helper'

describe Admin::EmployeesController do
  before do
    @employee = create(:employee, :with_password)
    admin = create(:admin)
    authorize_admin(admin)
  end

  describe 'GET employees#index' do
    before do
      get :index
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the index template' do
      expect(response).to render_template("index")
    end

    it 'assigns @providers' do
      expect(assigns(:providers)).to eq([@employee.provider])
    end
  end

  describe 'GET employees#new' do
    before do
      get :new
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the new template' do
      expect(response).to render_template("new")
    end

    it 'assigns @employee' do
      expect(assigns(:employee)).to be_new_record
    end
  end

  describe 'GET employees#edit' do
    before do
      get :edit, id: @employee.id
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

  describe 'GET employees#show' do
    before do
      get :show, id: @employee.id
    end

    it 'returns a successful status' do
      assert_response :success
    end

    it 'renders the show template' do
      expect(response).to render_template("show")
    end
  end

  describe 'POST employees#create' do
    context 'with valid employee info' do
      it 'creates a new employee' do
        expect {
          post :create, employee: attributes_for(:employee, :with_password)
        }.to change(Employee, :count)
      end

      it 'redirects to list of employees' do
        post :create, employee: attributes_for(:employee, :with_password)
        assert_redirected_to admin_employees_path
      end
    end

    context 'with invalid employee info' do
      it 'does not create a provider' do
        expect {
          post :create, employee: attributes_for(:employee, :with_password, name: nil)
        }.to_not change(Employee, :count)
      end

      it 'redirects to new employee view' do
        post :create, employee: attributes_for(:employee, :with_password, name: nil)
        assert_redirected_to new_admin_employee_path
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
          put :update, id: @employee.id, employee: attributes_for(:employee, :with_password, name: updated_name)
          @employee.reload
        }.to change(@employee, :name)
      end

      it 'redirects to list of employees' do
        put :update, id: @employee.id, employee: attributes_for(:employee, :with_password, name: updated_name)
        assert_redirected_to admin_employees_path
      end
    end

    context 'without password param' do
      it 'updates employee attributes' do
        expect {
          put :update, id: employee_no_password.id, employee: attributes_for(:employee, name: updated_name)
          employee_no_password.reload
        }.to change(employee_no_password, :name)
      end

      it 'redirects to list of employees' do
        put :update, id: employee_no_password.id, employee: attributes_for(:employee, name: updated_name)
        assert_redirected_to admin_employees_path
      end
    end
  end

  describe 'DELETE providers#destroy' do
    it 'removes employee from database' do
      expect {
        delete :destroy, id: @employee.id
      }.to change(Employee, :count)
    end

    it 'redirects to list of employees' do
      delete :destroy, id: @employee.id
      assert_redirected_to admin_employees_path
    end
  end
end
