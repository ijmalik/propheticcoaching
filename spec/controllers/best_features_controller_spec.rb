require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BestFeaturesController do

  # This should return the minimal set of attributes required to create a valid
  # BestFeature. As you add validations to BestFeature, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "title" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BestFeaturesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all best_features as @best_features" do
      best_feature = BestFeature.create! valid_attributes
      get :index, {}, valid_session
      assigns(:best_features).should eq([best_feature])
    end
  end

  describe "GET show" do
    it "assigns the requested best_feature as @best_feature" do
      best_feature = BestFeature.create! valid_attributes
      get :show, {:id => best_feature.to_param}, valid_session
      assigns(:best_feature).should eq(best_feature)
    end
  end

  describe "GET new" do
    it "assigns a new best_feature as @best_feature" do
      get :new, {}, valid_session
      assigns(:best_feature).should be_a_new(BestFeature)
    end
  end

  describe "GET edit" do
    it "assigns the requested best_feature as @best_feature" do
      best_feature = BestFeature.create! valid_attributes
      get :edit, {:id => best_feature.to_param}, valid_session
      assigns(:best_feature).should eq(best_feature)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BestFeature" do
        expect {
          post :create, {:best_feature => valid_attributes}, valid_session
        }.to change(BestFeature, :count).by(1)
      end

      it "assigns a newly created best_feature as @best_feature" do
        post :create, {:best_feature => valid_attributes}, valid_session
        assigns(:best_feature).should be_a(BestFeature)
        assigns(:best_feature).should be_persisted
      end

      it "redirects to the created best_feature" do
        post :create, {:best_feature => valid_attributes}, valid_session
        response.should redirect_to(BestFeature.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved best_feature as @best_feature" do
        # Trigger the behavior that occurs when invalid params are submitted
        BestFeature.any_instance.stub(:save).and_return(false)
        post :create, {:best_feature => { "title" => "invalid value" }}, valid_session
        assigns(:best_feature).should be_a_new(BestFeature)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        BestFeature.any_instance.stub(:save).and_return(false)
        post :create, {:best_feature => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested best_feature" do
        best_feature = BestFeature.create! valid_attributes
        # Assuming there are no other best_features in the database, this
        # specifies that the BestFeature created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        BestFeature.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => best_feature.to_param, :best_feature => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested best_feature as @best_feature" do
        best_feature = BestFeature.create! valid_attributes
        put :update, {:id => best_feature.to_param, :best_feature => valid_attributes}, valid_session
        assigns(:best_feature).should eq(best_feature)
      end

      it "redirects to the best_feature" do
        best_feature = BestFeature.create! valid_attributes
        put :update, {:id => best_feature.to_param, :best_feature => valid_attributes}, valid_session
        response.should redirect_to(best_feature)
      end
    end

    describe "with invalid params" do
      it "assigns the best_feature as @best_feature" do
        best_feature = BestFeature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BestFeature.any_instance.stub(:save).and_return(false)
        put :update, {:id => best_feature.to_param, :best_feature => { "title" => "invalid value" }}, valid_session
        assigns(:best_feature).should eq(best_feature)
      end

      it "re-renders the 'edit' template" do
        best_feature = BestFeature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BestFeature.any_instance.stub(:save).and_return(false)
        put :update, {:id => best_feature.to_param, :best_feature => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested best_feature" do
      best_feature = BestFeature.create! valid_attributes
      expect {
        delete :destroy, {:id => best_feature.to_param}, valid_session
      }.to change(BestFeature, :count).by(-1)
    end

    it "redirects to the best_features list" do
      best_feature = BestFeature.create! valid_attributes
      delete :destroy, {:id => best_feature.to_param}, valid_session
      response.should redirect_to(best_features_url)
    end
  end

end
