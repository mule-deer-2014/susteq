require 'rails_helper'

describe EmployeesController do
  before do
    @employee = FactoryGirl.create(:employee)
  end

  describe 'Response statuses' do
    describe 'GET employees#index' do
      it 'returns a successful status' do
        get :index, provider_id: @employee.provider_id
        assert_response :success
      end
    end

    describe 'GET employees#new' do
      it 'returns a successful status' do
        get :new, provider_id: @employee.provider_id
        assert_response :success
      end
    end

    describe 'GET employees#edit' do
      it 'returns a successful status' do
        get :edit, {id: @employee.id, provider_id: @employee.provider_id}
        assert_response :success
      end
    end

    describe 'GET employees#show' do
      it 'returns a successful status' do
        get :show, {id: @employee.id, provider_id: @employee.provider_id}
        assert_response :success
      end
    end
  end

  describe 'POST employees#create' do
    it 'creates a new employee' do
      expect {
        post :create, employee: FactoryGirl.attributes_for(:employee), provider_id: @employee.provider_id
      }.to change(Employee, :count)
    end

    it 'redirects to list of employees' do
      post :create, employee: FactoryGirl.attributes_for(:employee), provider_id: @employee.provider_id
      assert_redirected_to provider_employees_path
    end
  end
end
