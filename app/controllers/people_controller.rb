class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def new
    @person_form = PersonForm.new(
      page_params: params
    )
  end

  def update
    @person_form = PersonForm.new(
      page_params: params
    )
    if @person_form.update
      person_type = params[:return_to]
      redirect_to @person_form.send(person_type), notice: "#{person_type.capitalize} was successfully created."
    else
      render action: 'edit'
    end
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
