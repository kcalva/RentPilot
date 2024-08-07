class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.landlord?
      properties_path
    elsif resource.tenant?
      tenant_path(resource)
    else
      root_path
    end
  end
end
