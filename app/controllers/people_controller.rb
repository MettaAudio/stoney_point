class PeopleController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :show, :shirts]
  skip_before_filter :permit_only_admin, only: [:index, :show, :shirts]
  before_action :set_person, only: [:show, :destroy]

  def index
    if params[:show_all] == 'true'
      @people = Person.all.includes(:volunteer, :caddie, :golfer, :housings)
    elsif params[:show_volunteers] == 'true'
      @people = Person.active.volunteers.includes(:volunteer, :caddie, :golfer, :housings)
    else
      @people = Person.active.includes(:volunteer, :caddie, :golfer, :housings)
    end
  end

  def links
    if params[:show_all] == 'true'
      @people = Person.all.includes(:volunteer, :caddie, :golfer, :housings)
    elsif params[:show_volunteers] == 'true'
      @people = Person.active.volunteers.includes(:volunteer, :caddie, :golfer, :housings)
    else
      @people = Person.active.includes(:volunteer, :caddie, :golfer, :housings)
    end
  end

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

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    redirect_to :back
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
