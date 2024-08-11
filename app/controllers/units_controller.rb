class UnitsController < ApplicationController
  before_action :set_unit, only: %i[ edit update destroy ]

  # GET /units or /units.json
  def index
    @property = Property.find(params[:property_id])
    @units = @property.units
  end

  # GET /units/new
  def new
    @property = Property.find(params[:property_id])
    @unit = @property.units.new
  end

  # GET /units/1/edit
  def edit
    @property = Property.find(params[:property_id])
    @unit = @property.units.find(params[:id])
  end

  # POST /units or /units.json
  def create
    @property = Property.find(params[:property_id])
    @unit = @property.units.new(unit_params)
    respond_to do |format|
      if @unit.save
        format.html { redirect_to property_units_path(@property), notice: "Unit was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1 or /units/1.json
  def update
    @property = @unit.property
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to property_units_path(@property), notice: "Unit was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1 or /units/1.json
  def destroy
    @property = @unit.property
    @unit.destroy!

    respond_to do |format|
      format.html { redirect_to property_units_path(@property), notice: "Unit was successfully destroyed." }
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
