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

describe EbooksController do

  # This should return the minimal set of attributes required to create a valid
  # Ebook. As you add validations to Ebook, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EbooksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  include Devise::TestHelpers
  before (:each) do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "search" do
    it "searches ebooks" do
      ebook = FactoryGirl.create :ebook
      get :search, {:query => "Certification"}, valid_session
      assigns(:pages).first.ebook_name.should eq(ebook.name)
    end
  end

  describe "GET index" do
    it "assigns all ebooks as @ebooks" do
      ebook = Ebook.create! valid_attributes
      get :index, {}, valid_session
      assigns(:ebooks).should eq([ebook])
    end
  end

  describe "GET show" do
    it "assigns the requested ebook as @ebook" do
      ebook = Ebook.create! valid_attributes
      get :show, {:id => ebook.to_param}, valid_session
      assigns(:ebook).should eq(ebook)
    end
  end

  describe "GET new" do
    it "assigns a new ebook as @ebook" do
      get :new, {}, valid_session
      assigns(:ebook).should be_a_new(Ebook)
    end
  end

  describe "GET edit" do
    it "assigns the requested ebook as @ebook" do
      ebook = Ebook.create! valid_attributes
      get :edit, {:id => ebook.to_param}, valid_session
      assigns(:ebook).should eq(ebook)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Ebook" do
        expect {
          post :create, {:ebook => valid_attributes}, valid_session
        }.to change(Ebook, :count).by(1)
      end

      it "assigns a newly created ebook as @ebook" do
        post :create, {:ebook => valid_attributes}, valid_session
        assigns(:ebook).should be_a(Ebook)
        assigns(:ebook).should be_persisted
      end

      it "redirects to the created ebook" do
        post :create, {:ebook => valid_attributes}, valid_session
        response.should redirect_to(Ebook.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ebook as @ebook" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ebook.any_instance.stub(:save).and_return(false)
        post :create, {:ebook => {"name" => "invalid value"}}, valid_session
        assigns(:ebook).should be_a_new(Ebook)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ebook.any_instance.stub(:save).and_return(false)
        post :create, {:ebook => {"name" => "invalid value"}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ebook" do
        ebook = Ebook.create! valid_attributes
        # Assuming there are no other ebooks in the database, this
        # specifies that the Ebook created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Ebook.any_instance.should_receive(:update).with({"name" => "MyString"})
        put :update, {:id => ebook.to_param, :ebook => {"name" => "MyString"}}, valid_session
      end

      it "assigns the requested ebook as @ebook" do
        ebook = Ebook.create! valid_attributes
        put :update, {:id => ebook.to_param, :ebook => valid_attributes}, valid_session
        assigns(:ebook).should eq(ebook)
      end

      it "redirects to the ebook" do
        ebook = Ebook.create! valid_attributes
        put :update, {:id => ebook.to_param, :ebook => valid_attributes}, valid_session
        response.should redirect_to(ebook)
      end
    end

    describe "with invalid params" do
      it "assigns the ebook as @ebook" do
        ebook = Ebook.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Ebook.any_instance.stub(:save).and_return(false)
        put :update, {:id => ebook.to_param, :ebook => {"name" => "invalid value"}}, valid_session
        assigns(:ebook).should eq(ebook)
      end

      it "re-renders the 'edit' template" do
        ebook = Ebook.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Ebook.any_instance.stub(:save).and_return(false)
        put :update, {:id => ebook.to_param, :ebook => {"name" => "invalid value"}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ebook" do
      ebook = Ebook.create! valid_attributes
      expect {
        delete :destroy, {:id => ebook.to_param}, valid_session
      }.to change(Ebook, :count).by(-1)
    end

    it "redirects to the ebooks list" do
      ebook = Ebook.create! valid_attributes
      delete :destroy, {:id => ebook.to_param}, valid_session
      response.should redirect_to(ebooks_url)
    end
  end

end
