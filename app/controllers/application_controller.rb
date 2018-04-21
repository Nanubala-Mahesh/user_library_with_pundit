class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?


  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  

  private

    # def current_user
    #   @current_user ||= User.find_by(id: session[:user_id])
    # end
    
  	def check_for_valid_authtoken
	    @user = User.find_by(:access_token => params[:token])  
	    if @user 
        current_user = @user.id
	      return true
	    else
	      render :json => {:api => params[:api], :status => 0,:message => "Couldn't find user please login again"}   
	    end
	end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
    # devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :name) }
  end

	def user_not_authorized
		render :json => {:status => 0,:message => "not authorised"}
	end
end
