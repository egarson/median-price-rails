require 'spec_helper'

describe ItemsController do

  # the minimal set of attributes required to create a valid Sale
  let(:valid_attributes) { {} }
  let(:valid_session) { {} } # we're sessionless and stateless

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {:item => valid_attributes}, valid_session
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {:item => valid_attributes}, valid_session
        assigns(:item).should be_a(Item)
        assigns(:item).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item as @item" do
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        post :create, {:item => {  }}, valid_session
        assigns(:item).should be_a_new(Item)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item" do
        item = Item.create! valid_attributes
        Item.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => item.to_param, :item => { "these" => "params" }}, valid_session
      end

      it "assigns the requested item as @item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => valid_attributes}, valid_session
        assigns(:item).should eq(item)
      end
    end

    describe "with invalid params" do
      it "assigns the item as @item" do
        item = Item.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        put :update, {:id => item.to_param, :item => {  }}, valid_session
        assigns(:item).should eq(item)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}, valid_session
      }.to change(Item, :count).by(-1)
    end
  end
end
