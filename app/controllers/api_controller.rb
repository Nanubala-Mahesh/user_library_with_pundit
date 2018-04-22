class ApiController < ApplicationController
	protect_from_forgery with: :null_session


	private
	
	def current_user
      current_user ||= @user
    end
    
  	def check_for_valid_authtoken
	    @user = User.find_by(:access_token => params[:token])  
	    if @user 
        current_user = @user.id
	      return true
	    else
	      render :json => {:api => params[:api], :status => 0,:message => "Couldn't find user please login again"}   
	    end
	end

end