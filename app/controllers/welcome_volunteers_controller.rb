class WelcomeVolunteersController < ApplicationController
  layout "public"

  def new
    @person_form = PersonForm.new()
  end

  def new_find
  end

  def find
    @person = Person.find_by_first_name_and_last_name(search_params[:first_name], search_params[:last_name])
    if @person
      redirect_to edit_welcome_volunteer_path(@person.volunteer)
    else
      @name = "#{search_params[:first_name]} #{search_params[:last_name]}"
      render action: 'welcome'
    end
  end

  def welcome
  end

  def create
    params[:person_form][:person_is_active] = true

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
    @person    = Person.find(params[:id])
    @volunteer = @person.volunteer || Volunteer.new
    @welcome   = true

    @person_form = PersonForm.new(
      page_params: params,
      volunteer:   @volunteer,
      person:      @person
    )
  end

  def update
    params[:person_form][:person_is_active] = true

    @person    = Person.find(params[:id])
    @volunteer = @person.volunteer

    @person_form = PersonForm.new(
      page_params: params,
      volunteer:   @volunteer,
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
    params.require(:person).permit(
      :first_name,
      :last_name,
      :email,
      :street,
      :city,
      :state,
      :zip,
      :phone,
      :organization_id,
      :is_active
      )
  end

  def search_params
    params.require(:search).permit(
      :first_name,
      :last_name
    )
  end
end
