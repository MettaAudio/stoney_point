class CaddiesController < ApplicationController
  before_action :set_caddie, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /caddies
  # GET /caddies.json
  def index
    @caddies = Caddie.all
  end

  # GET /caddies/1
  # GET /caddies/1.json
  def show
  end

  # GET /caddies/new
  def new
    @caddie = Caddie.new
  end

  # GET /caddies/1/edit
  def edit
  end

  # POST /caddies
  # POST /caddies.json
  def create
    @caddie = Caddie.new(caddie_params)

    if @caddie.save
      redirect_to :back, notice: 'Caddie was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /caddies/1
  # PATCH/PUT /caddies/1.json
  def update
    respond_to do |format|
      if @caddie.update(caddie_params)
        format.html { redirect_to @caddie, notice: 'Caddie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @caddie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caddies/1
  # DELETE /caddies/1.json
  def destroy
    @caddie.destroy
    respond_to do |format|
      format.html { redirect_to caddies_url }
      format.json { head :no_content }
    end
  end

  def add_organization
    organization_id = params[:caddie][:organization_id]
    @caddie = Caddie.find(association_params[:id])
    if @caddie.update_attributes(:organization_id => organization_id )
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
      params.require(:caddie).permit(:first_name, :last_name, :phone, :school, :email, :comments, :golf, :rules, :course)
    end
end
