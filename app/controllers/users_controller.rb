class UsersController < ApplicationController
  before_action :set_tenant_resources
  # GET /user/1
  def show
  end

  private

  def set_tenant_resources
    @tenant = User.find(params[:id])
    @unit = @tenant.units.first
    if @unit
      @property = @unit.property
      @payments = @tenant.payments
    else
      @payments = []
    end
  end
end
