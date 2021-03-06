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

describe WorkDaysController do

  # This should return the minimal set of attributes required to create a valid
  # WorkDay. As you add validations to WorkDay, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "time" => "2013-12-05 14:07:06" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WorkDaysController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all work_days as @work_days" do
      work_day = WorkDay.create! valid_attributes
      get :index, {}, valid_session
      assigns(:work_days).should eq([work_day])
    end
  end

  describe "GET show" do
    it "assigns the requested work_day as @work_day" do
      work_day = WorkDay.create! valid_attributes
      get :show, {:id => work_day.to_param}, valid_session
      assigns(:work_day).should eq(work_day)
    end
  end

  describe "GET new" do
    it "assigns a new work_day as @work_day" do
      get :new, {}, valid_session
      assigns(:work_day).should be_a_new(WorkDay)
    end
  end

  describe "GET edit" do
    it "assigns the requested work_day as @work_day" do
      work_day = WorkDay.create! valid_attributes
      get :edit, {:id => work_day.to_param}, valid_session
      assigns(:work_day).should eq(work_day)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new WorkDay" do
        expect {
          post :create, {:work_day => valid_attributes}, valid_session
        }.to change(WorkDay, :count).by(1)
      end

      it "assigns a newly created work_day as @work_day" do
        post :create, {:work_day => valid_attributes}, valid_session
        assigns(:work_day).should be_a(WorkDay)
        assigns(:work_day).should be_persisted
      end

      it "redirects to the created work_day" do
        post :create, {:work_day => valid_attributes}, valid_session
        response.should redirect_to(WorkDay.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved work_day as @work_day" do
        # Trigger the behavior that occurs when invalid params are submitted
        WorkDay.any_instance.stub(:save).and_return(false)
        post :create, {:work_day => { "time" => "invalid value" }}, valid_session
        assigns(:work_day).should be_a_new(WorkDay)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        WorkDay.any_instance.stub(:save).and_return(false)
        post :create, {:work_day => { "time" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested work_day" do
        work_day = WorkDay.create! valid_attributes
        # Assuming there are no other work_days in the database, this
        # specifies that the WorkDay created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        WorkDay.any_instance.should_receive(:update).with({ "time" => "2013-12-05 14:07:06" })
        put :update, {:id => work_day.to_param, :work_day => { "time" => "2013-12-05 14:07:06" }}, valid_session
      end

      it "assigns the requested work_day as @work_day" do
        work_day = WorkDay.create! valid_attributes
        put :update, {:id => work_day.to_param, :work_day => valid_attributes}, valid_session
        assigns(:work_day).should eq(work_day)
      end

      it "redirects to the work_day" do
        work_day = WorkDay.create! valid_attributes
        put :update, {:id => work_day.to_param, :work_day => valid_attributes}, valid_session
        response.should redirect_to(work_day)
      end
    end

    describe "with invalid params" do
      it "assigns the work_day as @work_day" do
        work_day = WorkDay.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        WorkDay.any_instance.stub(:save).and_return(false)
        put :update, {:id => work_day.to_param, :work_day => { "time" => "invalid value" }}, valid_session
        assigns(:work_day).should eq(work_day)
      end

      it "re-renders the 'edit' template" do
        work_day = WorkDay.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        WorkDay.any_instance.stub(:save).and_return(false)
        put :update, {:id => work_day.to_param, :work_day => { "time" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested work_day" do
      work_day = WorkDay.create! valid_attributes
      expect {
        delete :destroy, {:id => work_day.to_param}, valid_session
      }.to change(WorkDay, :count).by(-1)
    end

    it "redirects to the work_days list" do
      work_day = WorkDay.create! valid_attributes
      delete :destroy, {:id => work_day.to_param}, valid_session
      response.should redirect_to(work_days_url)
    end
  end

end
