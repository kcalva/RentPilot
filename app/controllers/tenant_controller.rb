class TenantController < ApplicationController
  before_action :set_tenant_resources, only: [:show]

  private

  def set_tenant_resources
    @tenant = User.find(params[:id])
    @unit = @tenant.units.first
    @property = @unit&.property
    @payments = @tenant.payments
  end
end
