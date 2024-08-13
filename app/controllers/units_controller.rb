class UnitsController < ApplicationController
  before_action :set_property
  before_action :set_unit, only: %i[ edit update destroy ]

  # GET /units
  def index
    @units = @property.units
  end

  # GET /units/new
  def new
    @unit = @property.units.new
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  def create
    @unit = @property.units.new(unit_params)
    respond_to do |format|
      if @unit.save
        format.html { redirect_to property_units_path(@property), notice: "Unit was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to property_units_path(@property), notice: "Unit was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  def destroy
    @unit.destroy!
    respond_to do |format|
      format.html { redirect_to property_units_path(@property), notice: "Unit was successfully destroyed." }
    end
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def set_unit
    @unit = @property.units.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(:unit_number, :tenant_id)
  end
end
