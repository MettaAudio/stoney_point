class WelcomeVolunteersController < ApplicationController
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
      redirect_to edit_welcome_volunteer_path(@person)
    else
      if @attempt < 1
        @attempt += 1
        render action: 'returning'
      else
        render 'missing'
      end
    end
  end

  def welcome
  end

  def returning
    @attempt ||= 0
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
