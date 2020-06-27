class ApplicationController < ActionController::Base
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || posts_path
  end

  private

  def layout_by_resource
    'application'
    # if devise_controller?
    #   'base'
    # else
    #   'application'
    # end
  end
end
