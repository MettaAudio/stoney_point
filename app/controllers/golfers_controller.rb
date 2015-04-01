class GolfersController < ApplicationController
  before_action :set_golfer, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    if params[:show_all] == 'true'
      @golfers = Golfer.all.includes(:person, :caddies)
    else
      @golfers = Golfer.active.includes(:person, :caddies)
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
    @person = @golfer.person
    @person_form = PersonForm.new(
      page_params: params,
      golfer:      @golfer,
      person:      @person
    )
  end

  def create
    @golfer = Golfer.new
    @person = Person.find_by_id(params[:person_id]) || Person.new

    @person_form = PersonForm.new(
      page_params: params,
      golfer:      @golfer,
      person:      @person
    )
    if @person_form.update
      redirect_to @golfer, notice: 'Golfer was successfully created.'
    else
       render action: 'new'
    end
  end

  def add_caddie
    caddie_ids = params[:golfer][:caddie_ids]
    @golfer = Golfer.find(association_params[:id])
    if @golfer.update_attributes(:caddie_ids => caddie_ids )
      redirect_to :back, notice: "#{@golfer.full_name}'s caddies were updated."
    else
      redirect_to :back, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  def update
    @person = @golfer.person
    @person_form = PersonForm.new(
      page_params: params,
      golfer:      @golfer,
      person:      @person
    )
    if @person_form.update
      redirect_to @golfer, notice: 'Housing was successfully updated.'
    else
      render action: 'edit', notice: "Sorry, there was a problem saving your housing selection."
    end
  end

  def destroy
    @golfer.destroy
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_golfer
      @golfer = Golfer.find(params[:id])
    end

    def association_params
      params.require(:golfer).permit(:id)
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def golfer_params
      params.require(:golfer).permit(:first_name, :last_name, :email, :caddie_preferences, :is_active)
    end
end
