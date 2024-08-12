class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ edit update destroy ]

  # GET /properties or /properties.json
  def index
    @properties = current_user.owned_properties
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  def create
    @property = Property.new(property_params)
    @property.landlord = current_user

    respond_to do |format|
      if @property.save
        format.html { redirect_to properties_path(@property), notice: "Property was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to properties_path(@property), notice: "Property was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  def destroy
    @property.destroy!

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :address)
  end
end
