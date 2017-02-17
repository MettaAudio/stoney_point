class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy, :show_schedule]
  skip_before_filter :authenticate_user!, only: [:index, :show, :shirts, :show_all_schedules, :show_schedule, :show_day]
  skip_before_filter :permit_only_admin, only: [:index, :show, :shirts, :show_all_schedules, :show_schedule, :show_day]

  def index
    if params[:show_all] == 'true'
      @volunteers = Volunteer.all.includes(:committees, person: :organization)
    elsif params[:unassigned] == 'true'
      @volunteers = Volunteer.active.includes(:committees, person: :organization) - Volunteer.active.working.includes(:committees, person: :organization)
    else
      @volunteers = Volunteer.active.working.includes(:committees, person: :organization)
    end
  end

  def show
    if params[:show_all] == 'true'
      @volunteers = @committee.volunteers.includes(:committees, person: :organization)
    else
      @volunteers = @committee.volunteers.active.includes(:committees, person: :organization)
    end
  end

  def show_all_schedules
    @read_write = current_user.try(:admin?)
    @volunteers = Volunteer.with_scheduleable_committees.includes(:jobs, :committees, :person).active.uniq
    @days = ["thursday", "friday", "saturday", "sunday"]
    @job_options = Job.all.collect{ |j| { text: j.title, value: j.id } }
    render "show_schedule"
  end

  def show_schedule
    @read_write = current_user.try(:admin?) || current_user.try(:role) == "#{@committee.name.titlecase} Manager"
    @volunteers = @committee.volunteers.includes(:jobs, :committees, :person).active
    @job_options = Job.all.collect{ |j| { text: j.title, value: j.id } }
    @days = ["thursday", "friday", "saturday", "sunday"]
  end

  def show_day
    @read_write = current_user.try(:manage_committees?) || current_user.try(:volunteer_center_manager?)
    @day = params[:day]
    @committees = Committee.sorted.scheduleable
    @volunteers = Volunteer.with_scheduleable_committees.includes(:jobs, :committees, :person).active.schedule_for(@day).uniq
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
