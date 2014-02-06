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

describe MenteesController do

  # This should return the minimal set of attributes required to create a valid
  # Mentee. As you add validations to Mentee, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { email: 'test@test.com', first_name: 'test', last_name: 'user' } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MenteesController. Be sure to keep this updated too.
  let(:valid_session) { { } }

  describe "GET index" do
    it "assigns all mentees as @mentees" do
      user = FactoryGirl.create :user
      mentee = user.mentees.create! valid_attributes
      get :index, { user_id: user.id }, valid_session
      assigns(:mentees).should eq([mentee])
    end
  end

  describe "GET show" do
    it "assigns the requested mentee as @mentee" do
      mentee = Mentee.create! valid_attributes
      get :show, {:id => mentee.to_param}, valid_session
      assigns(:mentee).should eq(mentee)
    end
  end

  describe "GET new" do
    it "assigns a new mentee as @mentee" do
      get :new, {}, valid_session
      assigns(:mentee).should be_a_new(Mentee)
    end
  end

  describe "GET edit" do
    it "assigns the requested mentee as @mentee" do
      mentee = Mentee.create! valid_attributes
      get :edit, {:id => mentee.to_param}, valid_session
      assigns(:mentee).should eq(mentee)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Mentee" do
        expect {
          post :create, {:mentee => valid_attributes}, valid_session
        }.to change(Mentee, :count).by(1)
      end

      it "assigns a newly created mentee as @mentee" do
        post :create, {:mentee => valid_attributes}, valid_session
        assigns(:mentee).should be_a(Mentee)
        assigns(:mentee).should be_persisted
      end

      it "redirects to the created mentee" do
        post :create, {:mentee => valid_attributes}, valid_session
        response.should redirect_to(Mentee.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved mentee as @mentee" do
        # Trigger the behavior that occurs when invalid params are submitted
        Mentee.any_instance.stub(:save).and_return(false)
        post :create, {:mentee => { "name" => "invalid value" }}, valid_session
        assigns(:mentee).should be_a_new(Mentee)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Mentee.any_instance.stub(:save).and_return(false)
        post :create, {:mentee => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end
  #
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested mentee" do
        mentee = Mentee.create! valid_attributes
        # Assuming there are no other mentees in the database, this
        # specifies that the Mentee created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Mentee.any_instance.should_receive(:update).with({ "index" => "MyString" })
        put :update, {:id => mentee.to_param, :mentee => { "index" => "MyString" }}, valid_session
      end

      it "assigns the requested mentee as @mentee" do
        mentee = Mentee.create! valid_attributes
        put :update, {:id => mentee.to_param, :mentee => valid_attributes}, valid_session
        assigns(:mentee).should eq(mentee)
      end

      it "redirects to the mentee" do
        mentee = Mentee.create! valid_attributes
        put :update, {:id => mentee.to_param, :mentee => valid_attributes}, valid_session
        response.should redirect_to(mentee)
      end
    end

    describe "with invalid params" do
      it "assigns the mentee as @mentee" do
        mentee = Mentee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Mentee.any_instance.stub(:save).and_return(false)
        put :update, {:id => mentee.to_param, :mentee => { "name" => "invalid value" }}, valid_session
        assigns(:mentee).should eq(mentee)
      end

      it "re-renders the 'edit' template" do
        mentee = Mentee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Mentee.any_instance.stub(:save).and_return(false)
        put :update, {:id => mentee.to_param, :mentee => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested mentee" do
      mentee = Mentee.create! valid_attributes
      expect {
        delete :destroy, {:id => mentee.to_param}, valid_session
      }.to change(Mentee, :count).by(-1)
    end

    it "redirects to the mentees list" do
      mentee = Mentee.create! valid_attributes
      delete :destroy, {:id => mentee.to_param}, valid_session
      response.should redirect_to(mentees_url)
    end
  end

end
