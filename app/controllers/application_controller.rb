class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_student

  rescue_from CanCan::AccessDenied do
		redirect_to root_path ,notice: "The page you are looking for doesn't exist"
	end 

  def current_student
    @current_student ||= current_user.student
  end

  protected

  def after_sign_in_path_for(resource)
    (resource.role? "student") ?  batches_path : root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:username])
  end
end
