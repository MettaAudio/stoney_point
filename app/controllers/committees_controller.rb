class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @volunteers = Volunteer.active.working
  end

  def show
    @volunteers = @committee.volunteers.active
  end

  def new
    @committee = Committee.new
  end

  def edit
  end

  def create
    @committee = Committee.new(committee_params)
    if @committee.save
      redirect_to :back, notice: 'Committee was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @committee.update(committee_params)
       redirect_to @committee, notice: 'Committee was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @committee.destroy
    redirect_to committees_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_committee
      @committee = Committee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def committee_params
      params.require(:committee).permit(:name)
    end
end
