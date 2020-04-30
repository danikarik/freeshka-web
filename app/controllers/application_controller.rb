class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

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

  def configure_permitted_parameters
    update_keys = [:email, :name, :description, :org_form_id,
                   :password, :password_confirmation, :current_password]

    devise_parameter_sanitizer.permit(:account_update, keys: update_keys)
  end
end
