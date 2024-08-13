class LeasesController < ApplicationController
  before_action :set_lease, only: %i[ edit update destroy ]
  before_action :set_tenant_and_unit, only: %i[ new create edit update ]

  # GET /leases
  def index
    @tenant = User.find(params[:user_id])
    @current_lease = @tenant.leases.where("start_date <= ? AND end_date >= ?", Date.today, Date.today).first
    @past_leases = @tenant.leases.where("end_date < ?", Date.today)
  end

  # GET /leases/new
  def new
    @lease = @tenant.leases.new
  end

  # GET /leases/1/edit
  def edit
  end

  # POST /leases
  def create
    @lease = @tenant.leases.new(lease_params.merge(unit: @unit))

    respond_to do |format|
      if @lease.save
        format.html { redirect_to user_leases_path(@lease.tenant), notice: "Lease was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leases/1
  def update
    respond_to do |format|
      if @lease.update(lease_params)
        format.html { redirect_to user_leases_path(@lease.tenant), notice: "Lease was successfully updated." }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /leases/1
  def destroy
    @lease.destroy!

    respond_to do |format|
      format.html { redirect_to user_leases_path(@lease.tenant), notice: "Lease was successfully destroyed." }
    end
  end

  private

  def set_lease
    @lease = Lease.find(params[:id])
  end

  def set_tenant_and_unit
    @tenant = User.find(params[:user_id])
    @unit = @tenant.units.first
  end

  def lease_params
    params.require(:lease).permit(:start_date, :end_date, :rent_amount, :security_deposit, :pdf)
  end
end
