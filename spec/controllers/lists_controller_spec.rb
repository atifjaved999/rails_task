require 'rails_helper'

RSpec.describe ListsController, type: :controller do

  let(:valid_attributes) {
    {name: 'List 01', country: 'PK', city: 'Lahore', information_file: fixture_file_upload('files/vendors.xlsx', 'file')} 
  }

  let(:invalid_attributes) {
    {name: '', country: 'PK', city: 'Lahore'} 
  }

  before(:each) do |test|
    unless test.metadata[:skip_before]
      @list = List.create! valid_attributes
    end
  end

  context "GET #index", skip_before: true do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  context "GET #new", skip_before: true do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  context "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: @list.to_param}
      expect(response).to be_successful
    end
  end
 
  describe "POST #create", skip_before: true do
    context "with valid params" do
      subject {post :create, params: {list: valid_attributes}}
      it "creates a new List" do
        expect { subject }.to change(List, :count).by(1)
      end
    end

    context "with invalid params" do
      subject {post :create, params: {list: invalid_attributes}}

      it "Fails to create a new List" do
        expect { subject }.to change(List, :count).by(0)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let (:new_valid_attributes) {
        {name: 'List 01 -- updated'} 
      }
      subject {put :update, params: {id: @list.to_param, list: new_valid_attributes}}

      it "updates the requested list" do
        subject
        @list.reload
      end
      it "udpates a new List" do
        subject
        @list.reload
        expect(@list.name).to eq new_valid_attributes[:name]
      end
    end

    context "with invalid params" do
      let (:new_invalid_attributes) {
        {name: ''} 
      }

      subject {put :update, params: {id: @list.to_param, list: new_invalid_attributes}}

      it "Fails to update the requested list" do
        subject
        @list.reload
        expect(@list.name).not_to be new_invalid_attributes[:name]
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested list" do
      expect {
        delete :destroy, params: {id: @list.to_param}
      }.to change(List, :count).by(-1)
    end
  end

  context "GET #cities" do
    it "returns a success response" do
      subject {get :cities, params: {country: @list.country}}
      expect(response).to be_successful
    end
  end

end
