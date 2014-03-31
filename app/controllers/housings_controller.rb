class HousingsController < ApplicationController
  before_action :set_housing, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /housings
  # GET /housings.json
  def index
    @housings = Housing.all
  end

  # GET /housings/1
  # GET /housings/1.json
  def show
  end

  # GET /housings/new
  def new
    @housing = Housing.new
  end

  # GET /housings/1/edit
  def edit
  end

  # POST /housings
  # POST /housings.json
  def create
    @housing = Housing.new(housing_params)

    respond_to do |format|
      if @housing.save
        format.html { redirect_to @housing, notice: 'Housing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @housing }
      else
        format.html { render action: 'new' }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /housings/1
  # PATCH/PUT /housings/1.json
  def update
    respond_to do |format|
      if @housing.update(housing_params)
        format.html { redirect_to @housing, notice: 'Housing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /housings/1
  # DELETE /housings/1.json
  def destroy
    @housing.destroy
    respond_to do |format|
      format.html { redirect_to housings_url }
      format.json { head :no_content }
    end
  end

  def add_golfer
    @housing = Housing.find(association_params[:id])
    golfer_id = params[:housing][:golfer_id]
    if @housing.update_attributes(:golfer_id => golfer_id)
      redirect_to @housing, notice: "Golfer added!"
    else
      redirect_to @housing, notice: "We're sorry, an error has occurred. Please try again."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_housing
      @housing = Housing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def housing_params
      params.require(:housing).permit(:available, :number_of_bedrooms, :number_of_bathrooms, :pets, :smoking, :comments, :golfer_ids => [])
    end

    def association_params
      params.require(:housing).permit(:id)
    end

end
