class WelcomeHousingController < ApplicationController
  skip_before_filter :permit_only_admin
  skip_before_filter :authenticate_user!
  layout "public"

  def new
    @person_form = PersonForm.new()
  end

  def find
    @attempt = params[:attempt].to_i
    # Case insensitive search
    t = Person.arel_table
    @first_name = search_params[:first_name].strip
    @last_name  = search_params[:last_name].strip
    @person = Person.where(t[:first_name].matches(@first_name).and(t[:last_name].matches(@last_name))).last

    if @person
      redirect_to edit_welcome_housing_path(@person)
    else
      @attempt += 1
      render action: 'returning'
    end
  end

  def welcome
  end

  def returning
    @attempt ||= 0
  end

  def create
    params[:person_form][:person_is_active] = true
    params[:person_form][:housing][:is_active] = true

    @person_form = PersonForm.new(
      page_params: params
    )
    if @person_form.update
      render action: 'thank_you'
    else
      render action: 'new', notice: "First and Last name are required. Please try again."
    end
  end

  def edit
    @person = Person.find(params[:id])
    @housing = @person.housings.first
    @person_form = PersonForm.new(
      page_params: params,
      housing:     @housing,
      person:      @person
    )
  end

  def update
    params[:person_form][:person_is_active] = true
    params[:person_form][:housing][:is_active] = true

    @person    = Person.find(params[:id])
    @housing   = @person.housings.first

    @person_form = PersonForm.new(
      page_params: { person_form: person_params },
      housing:     @housing,
      person:      @person
    )
    if @person_form.update
      render :thank_you
    else
      render action: 'edit', notice: "There was a problem saving."
    end
  end

  def thank_you
    render layout: "public"
  end

  private
  def set_person
    @person = Person.find(params[:id])
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
        :person_is_active,
        housing: [
          :number_of_bedrooms,
          :number_of_bathrooms,
          :max_guests,
          :pets,
          :available,
          :specific_golfers,
          :smoking,
          :comments,
          :is_active,
          :waiver,
          golfer_ids: [],
        ]
      )
    end
  end

  def search_params
    params.require(:search).permit(
      :first_name,
      :last_name
    )
  end
end
