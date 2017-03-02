class HousingsController < ApplicationController
  before_action :set_housing, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index, :show, :shirts]
  skip_before_filter :permit_only_admin, only: [:index, :show, :shirts, :update]

  def index
    if params[:show_all] == 'true'
      @housings = Housing.all.includes(:person, golfers: :person)
      @number_of_beds = Housing.total_number_of_beds(:all)
    else
      @housings = Housing.active.includes(:person, golfers: :person)
      @number_of_beds = Housing.total_number_of_beds(:active)
    end
  end

  def show
    @housings = @housing.person.housings
  end

  def new
    @person_form = PersonForm.new(
      person: Person.find_by_id(params[:person_id])
    )
  end

  def edit
    @person = @housing.person
    @person_form = PersonForm.new(
      page_params: params,
      housing:     @housing,
      person:      @person
    )
  end

  def create
    @person = Person.find_by_id(params[:person_id]) || Person.new

    @person_form = PersonForm.new(
      page_params: params,
      person:      @person
    )

    if @person_form.update
      redirect_to @person_form.housing, notice: 'Housing was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @person = @housing.person
    @person_form = PersonForm.new(
      page_params: params,
      housing_params: person_params.try(:[], :housing) || housing_params,
      housing:     @housing,
      person:      @person
    )

    if @person_form.update
      respond_to do |format|
        format.html { redirect_to @housing, notice: 'Housing was successfully updated.' }
        format.js   { render json: @housing.to_json }
      end
    else
      respond_to do |format|
        format.json { render json: @housing.errors, status: :unprocessable_entity }
        format.html { render action: 'edit', notice: "Sorry, there was a problem saving your housing selection." }
      end
    end
  end

  def destroy
    @housing.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def add_golfer
    @housing = Housing.find(association_params[:id])
    golfer_id = params[:housing][:golfer_id]
    if @housing.update_attributes(:golfer_id => golfer_id)
      redirect_to @housing, notice: "Golfer added!"
    else
      redirect_to @housing, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_housing
      @housing = Housing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def housing_params
      params.require(:housing).permit(
        :available,
        :number_of_bedrooms,
        :number_of_bathrooms,
        :pets,
        :smoking,
        :comments,
        :max_guests,
        :specific_golfers,
        :is_active,
        :waiver,
        :golfer_ids,
        golfer_ids: [],
      )
    end

  def person_params
    if params[:person_form].present?
      params.require(:person_form).permit(
        :person_first_name,
        :person_last_name,
        :person_email,
        :person_street,
        :person_city,
        :person_state,
        :person_zip,
        :person_phone,
        :person_organization_id,
        :person_is_active
        )
    end
  end

    def association_params
      params.require(:housing).permit(:id)
    end

end
