class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
      user_activity_feeds_path(current_user)
  end

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name,:email, :password])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name,:last_name,:email, :password])
  end

  # TODO: make the activity feeds after the last_sign_in appear first
  # TODO: clear up the user interface, uptil and do code refactoring, 
  # after this the main fucntionality is complete and start focusing 
  # on the testing using test/unit and repec
  # TODO: After that the project is now completely deployable
end
