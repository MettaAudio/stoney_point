class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /volunteers
  # GET /volunteers.json
  def index
    @volunteers = Volunteer.all
  end

  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
  end

  # GET /volunteers/new
  def new
    @volunteer = Volunteer.new
  end

  # GET /volunteers/1/edit
  def edit
    @committees = Committee.all
    @housing = Housing.new
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @volunteer = Volunteer.new(volunteer_params)

    respond_to do |format|
      if @volunteer.save
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @volunteer }
      else
        format.html { render action: 'new' }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /volunteers/1
  # PATCH/PUT /volunteers/1.json
  def update
    respond_to do |format|
      if @volunteer.update(volunteer_params)
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_committee
    @volunteer = Volunteer.find(association_params[:id])
    committee_ids = params[:volunteer][:committee_ids]
    if @volunteer.update_attributes(:committee_ids => committee_ids)
      redirect_to @volunteer, notice: "#{@volunteer.full_name}'s committees were updated."
    else
      redirect_to @volunteer, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def add_job
    job_ids = params[:volunteer][:job_ids]
    @volunteer = Volunteer.find(association_params[:id])
    if @volunteer.update_attributes(:job_ids => job_ids )
      redirect_to @volunteer, notice: "#{@volunteer.full_name}'s jobs were updated."
    else
      redirect_to @volunteer, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def add_organization
    organization_id = params[:volunteer][:organization_id]
    @volunteer = Volunteer.find(association_params[:id])
    if @volunteer.update_attributes(:organization_id => organization_id )
      redirect_to @volunteer, notice: "#{@volunteer.full_name}'s organization was updated."
    else
      redirect_to @volunteer, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def add_housing
    @volunteer = Volunteer.find(housing_params[:volunteer_id])
    @housing = Housing.new( housing_params )
    if @housing.save
      redirect_to @volunteer, notice: "#{@volunteer.full_name}'s housing was added."
    else
      @committees = Committee.all
      flash[:error] = "There was a problem adding your housing. Please try again."
      render action: 'edit'
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.json
  def destroy
    @volunteer.destroy
    respond_to do |format|
      format.html { redirect_to volunteers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      params.require(:volunteer).permit(:first_name, :last_name, :street, :city, :state, :zip, :zip, :primary_phone, :secondary_phone, :email, :paid, :physical_activity, :shirt_size, :comments)
    end

    def association_params
      params.require(:volunteer).permit(:id)
    end

    def housing_params
      params.require(:housing).permit(:volunteer_id, :available, :number_of_bedrooms, :number_of_bathrooms, :pets, :smoking, :comments)
    end
end
