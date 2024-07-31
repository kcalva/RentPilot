class DashboardController < ApplicationController
  before_action :set_tenant_resources, only: [:tenant]

  def index
    if current_user.landlord?
      set_landlord_resources
      render "landlord"
    elsif current_user.tenant?
      set_tenant_resources(current_user)
      render "tenant"
    else
      redirect_to new_user_session_path, alert: "Unauthorized access"
    end
  end

  private

  def set_landlord_resources
    @properties = current_user.owned_properties
  end

  def set_tenant_resources(user = nil)
    user ||= User.find(params[:id])
    @tenant = user
    @unit = @tenant.units.first
    @property = @unit&.property
    @payments = @tenant.payments
  end
end
