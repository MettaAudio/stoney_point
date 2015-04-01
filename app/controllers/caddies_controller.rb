class CaddiesController < ApplicationController
  before_action :set_caddie, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    if params[:show_all] == 'true'
      @caddies = Caddie.by_last_name
    else
      @caddies = Caddie.active.by_last_name
    end
  end

  def show
  end

  def new
    @person_form = PersonForm.new(
      person: Person.find_by_id(params[:person_id])
    )
  end

  def edit
    @person = @caddie.person
    @person_form = PersonForm.new(
      page_params: params,
      caddie:      @caddie,
      person:      @person
    )
  end

  def create
    @caddie = Caddie.new
    @person = Person.find_by_id(params[:person_id]) || Person.new
    @person_form = PersonForm.new(
      page_params: params,
      caddie:      @caddie,
      person:      @person
    )

    if @person_form.update
      redirect_to :back, notice: 'Caddie was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @person = @caddie.person
    @person_form = PersonForm.new(
      page_params: params,
      caddie:      @caddie,
      person:      @person
    )
    if @person_form.update
       redirect_to @caddie, notice: 'Caddie was successfully updated.'
    else
       render action: 'edit'
    end
  end

  def destroy
    @caddie.destroy
    redirect_to :back
  end

  def add_organization
    organization_id = params[:caddie][:organization_id]
    @caddie = Caddie.find(association_params[:id])
    if @caddie.person.update_attributes(:organization_id => organization_id )
      redirect_to :back, notice: "#{@caddie.full_name}'s organization was updated."
    else
      redirect_to :back, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caddie
      @caddie = Caddie.find(params[:id])
    end

    def association_params
      params.require(:caddie).permit(:id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def caddie_params
      params.require(:caddie).permit(:first_name, :last_name, :phone, :email, :comments, :golf, :rules, :course, :is_active)
    end
end
