class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper ApplicationHelper
  before_filter :configure_permited_parameters,if: :devise_controller?






  protected

  def configure_permited_parameters
  	devise_parameter_sanitizer.for(:sign_up) << :subdomain
  end
end
