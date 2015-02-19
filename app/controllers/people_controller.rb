class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def new
  end

  def create
  end

  def show
  end

  def edit
    @person_form = PersonForm.new(
      page_params: params
    )
    @committees   = Committee.all
    @committee    = Committee.new
    @job          = Job.new
    @shift        = Shift.new
    @organization = Organization.new
    @housing      = Housing.new
  end

  def update
    @person_form = PersonForm.new(
      page_params: params
    )
    if @person_form.update
      redirect_to @person_form.person, notice: 'Person was successfully created.'
    else
      render action: 'edit'
    end
  end

  def destroy
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
