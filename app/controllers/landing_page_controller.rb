class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
end
