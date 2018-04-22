class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  
  # binding.pry
  before_action :configure_permitted_parameters, if: :devise_controller?


  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # before_action :set_current_user
  

  private

  def set_current_user
    # binding.pry
    @current_user = @user
    
  end
    

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
    # devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :name) }
  end

	def user_not_authorized
		render :json => {:status => 0,:message => "not authorised"}
	end
end
