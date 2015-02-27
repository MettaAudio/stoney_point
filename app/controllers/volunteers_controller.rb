class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    if params[:show_all] == 'true'
      @volunteers = Volunteer.all
    else
      @volunteers = Volunteer.active.working
    end
  end

  def address_list
    if params[:show_all] == 'true'
      @volunteers = Volunteer.all
    else
      @volunteers = Volunteer.active
    end
  end

  def duplicate
    id = params[:volunteer_id]
    volunteer = Volunteer.find(id)
    if volunteer
      duplicate_volunteer = volunteer.duplicate!
      if duplicate_volunteer
        redirect_to edit_volunteer_path(duplicate_volunteer), notice: 'Volunteer duplicated!.'
      else
        redirect_to :back, notice: 'Sorry, there was an error duplicating that volunteer. Sorry it didn\'t work out.'
      end
    else
      redirect_to :back, notice: 'No volunteer was found to duplicate.'
    end
  end

  def shirts
    @volunteers = Volunteer.active.receiving_shirts
    @shirts_paid = Volunteer.active.number_of_shirts_paid
    @shirts_unpaid = Volunteer.active.number_of_shirts_unpaid
    @shirts_unknown = Volunteer.active.number_of_shirts_unknown
  end

  def show
  end

  def new
    @person_form = PersonForm.new()
  end

  def edit
    @person = @volunteer.person
    @person_form = PersonForm.new(
      page_params: params,
      volunteer:   @volunteer,
      person:      @person
    )
    @committees   = Committee.all
    @committee    = Committee.new
    @job          = Job.new
    @shift        = Shift.new
    @organization = Organization.new
    @housing      = Housing.new
  end

  def create
    @volunteer_form = VolunteerForm.new(
      page_params: params,
      form_params: params["volunteer_form"]
    )

    if @volunteer_form.save
      redirect_to @volunteer_form.volunteer, notice: 'Volunteer was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @person = @volunteer.person
    @person_form = PersonForm.new(
      page_params: params,
      volunteer:   @volunteer,
      person:      @person
    )
    if @person_form.update
      redirect_to @person_form.volunteer, notice: 'Person was successfully created.'
    else
      @committees   = Committee.all
      @committee    = Committee.new
      @job          = Job.new
      @shift        = Shift.new
      @organization = Organization.new
      @housing      = Housing.new
      render action: 'edit', notice: "There was a problem saving."
    end
  end

  def add_committee
    @volunteer = Volunteer.find(association_params[:id])
    committee_ids = params[:volunteer][:committee_ids]
    if @volunteer.update_attributes(:committee_ids => committee_ids)
      redirect_to :back, notice: "#{@volunteer.full_name}'s committees were updated."
    else
      redirect_to :back, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def add_job
    @volunteer = Volunteer.find(association_params[:id])
    job_ids = params[:volunteer][:job_ids]
    if @volunteer.update_attributes(:job_ids => job_ids)
      redirect_to :back, notice: "#{@volunteer.full_name}'s jobs were updated."
    else
      redirect_to :back, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def add_shift
    @volunteer = Volunteer.find(association_params[:id])
    shift_ids = params[:volunteer][:shift_ids]
    if @volunteer.update_attributes(:shift_ids => shift_ids)
      redirect_to :back, notice: "#{@volunteer.full_name}'s shifts were updated."
    else
      redirect_to :back, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def add_organization
    organization_id = params[:volunteer][:organization_id]
    @volunteer = Volunteer.find(association_params[:id])
    if @volunteer.person.update_attributes(:organization_id => organization_id )
      redirect_to :back, notice: "#{@volunteer.full_name}'s organization was updated."
    else
      redirect_to :back, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def add_housing
    @volunteer   = Volunteer.find(housing_params[:volunteer_id])
    @person      = @volunteer.person
    @person_form = PersonForm.new(
      page_params: params,
      person:      @person
    )
    if @person_form.update
      redirect_to :back, notice: "#{@volunteer.full_name}'s housing was added."
    else
      @committees = Committee.all
      flash[:error] = "There was a problem adding your housing. Please try again."
      render action: 'edit'
    end
  end

  def destroy
    @volunteer.person.destroy
    redirect_to volunteers_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      params.require(:volunteer).permit(
        :first_name,
        :last_name,
        :street,
        :city,
        :state,
        :zip,
        :zip,
        :primary_phone,
        :secondary_phone,
        :email,
        :paid,
        :physical_activity,
        :shirt_size,
        :comments,
        :availability,
        :sessions,
        :number_of_shirts,
        :golfer,
        :waiver,
        :is_active
        )
    end

    def association_params
      params.require(:volunteer).permit(:id)
    end

    def housing_params
      params.require(:housing).permit(:volunteer_id, :available, :number_of_bedrooms, :number_of_bathrooms, :pets, :smoking, :comments, :golfer_ids => [])
    end
end
