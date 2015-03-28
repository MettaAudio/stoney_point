class WelcomeCaddiesController < ApplicationController
  layout "public"

  def new
    @person_form = PersonForm.new()
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
    @caddie = @person.caddie || Caddie.new
    @welcome   = true

    @person_form = PersonForm.new(
      page_params: params,
      caddie:      @caddie,
      person:      @person
    )
  end

  def update
    params[:person_form][:person_is_active] = true

    @person = Person.find(params[:id])
    @caddie = @person.caddie

    @person_form = PersonForm.new(
      page_params: params,
      caddie:      @caddie,
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
end
