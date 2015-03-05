class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /committees
  # GET /committees.json
  def index
    @committees = Committee.all
  end

  # GET /committees/1
  # GET /committees/1.json
  def show
    @volunteers = @committee.volunteers.active
  end

  # GET /committees/new
  def new
    @committee = Committee.new
  end

  # GET /committees/1/edit
  def edit
  end

  # POST /committees
  # POST /committees.json
  def create
    @committee = Committee.new(committee_params)
    if @committee.save
      redirect_to :back, notice: 'Committee was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /committees/1
  # PATCH/PUT /committees/1.json
  def update
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to @committee, notice: 'Committee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1
  # DELETE /committees/1.json
  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_url }
      format.json { head :no_content }
    end
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
