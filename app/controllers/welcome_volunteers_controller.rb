class WelcomeVolunteersController < ApplicationController
  layout "public"

  def new
    @person_form = PersonForm.new()
  end

  def find
    @attempt = params[:attempt].to_i
    if @attempt < 1
      # Case insensitive search
      t = Person.arel_table
      @person = Person.where(t[:first_name].matches(search_params[:first_name]).and(t[:last_name].matches(search_params[:last_name]))).last
      if @person
        redirect_to edit_welcome_volunteer_path(@person)
      else
        @attempt    = @attempt + 1
        @first_name = search_params[:first_name]
        @last_name  = search_params[:last_name]
        render action: 'returning'
      end
    else
      # Send email
        flash[:warning] = nil
      render 'missing'
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
