class UnitsController < ApplicationController
  before_action :set_unit, only: %i[ show edit update destroy ]

  # GET /units or /units.json
  def index
    @units = Unit.all
  end

  # GET /units/1 or /units/1.json
  def show
  end

  # GET /units/new
  def new
    @property = Property.find(params[:property_id])
    @unit = Unit.new(property_id: @property.id)
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units or /units.json
  def create
    @property = Property.find(params[:unit][:property_id])
    @unit = @property.units.new(unit_params)
    respond_to do |format|
      if @unit.save
        format.html { redirect_to units_property_path(@property), notice: "Unit was successfully created." }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1 or /units/1.json
  def update
    @property = @unit.property
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to units_property_path(@property), notice: "Unit was successfully updated." }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1 or /units/1.json
  def destroy
    @property = @unit.property
    @unit.destroy!

    respond_to do |format|
      format.html { redirect_to units_property_path(@property), notice: "Unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_unit
    @unit = Unit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def unit_params
    params.require(:unit).permit(:property_id, :unit_number, :tenant_id)
  end
end
