class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
  	@user || current_user  	
  end

  private

  	def check_for_valid_authtoken
	    @user = User.find_by(:access_token => params[:token])  
	    if @user 
	      return true
	    else
	      render :json => {:api => params[:api], :status => 0,:message => "Couldn't find user please login again"}   
	    end
	end

	def user_not_authorized
		render :json => {:status => 0,:message => "not authorised"}
	end
end
