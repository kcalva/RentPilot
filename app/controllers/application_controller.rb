class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end
end
