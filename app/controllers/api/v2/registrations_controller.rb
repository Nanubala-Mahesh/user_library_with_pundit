class Api::V2::RegistrationsController < ApplicationController
	
	def sign_up
	    if params[:email].nil?
	      render :status => 400,
	      :json => {:message => 'email required.'}
	      return
	    elsif params[:password].nil? || params[:password_confirmation].nil?
	      render :status => 400,
	      :json => {:message => 'password required.'}
	      return
	  	elsif params[:type] != 'Normal' && params[:type] != 'Admin'  
	      	render :status => 400,
	      	:json => {:message => 'type required Normal or Admin Capitalize.'}
	      return
	    end

	    if params[:email]
	      duplicate_user = User.find_by_email(params[:email])
	      unless duplicate_user.nil?
	        render :status => 409,
	        :json => {:message => 'Duplicate email. A user already exists with that email address.'}
	        return
	      end
	    end

	    if params[:type] == 'Admin'
	    	@user = Admin.create(sign_up_params)
	    elsif params[:type] == 'Normal'
	    	@user = Normal.create(sign_up_params)
	    end
	    if @user.persisted?
		    if @user.save!
		      render :json => {:user => @user}
		      return
		    else
		      render :status => 400,
		      :json => {:message => @user.errors.full_messages}
		    end
		end
		render :status => 400,
		      :json => {:message => @user.errors.full_messages}
		 return
	end

	def sign_in
		if params[:email].nil? && params[:password].nil?
	      @user.errors.full_messages
	  	else
	    	@user = User.find_by_email(params[:email])
	    	if @user
		    	if @user.valid_password?(params[:password])
		    		# binding.pry
		    		if @user.access_token.nil?

						auth_token = rand_string(20)
						# auth_expiry = Time.now + (24*60*60)
						@user.access_token = auth_token
				        #@user.authtoken_expiry = auth_expiry
				        if @user.save(validate: false)
				        	puts 'updated the parameters'
				        else
				        	puts 'couldnt update the parameters'
				        end
					end
		    		render :json => {:user => @user }
		    	else
		    		render :json => {:message => 'wrong password' }
		    	end
		    else
		    	render :json => {:message => 'wrong email' }
		    end
	    end			
	end

	def invite_user
		if params[:email]
			@user = User.find_by_email(params[:email])
			unless @user
				User.invite!(:email => params[:email], :name => "test")
				render :json => {:message => 'invited successfully' }
			else
				render :json => {:message => 'email exit'}
			end
		else
		    render :json => {:message => 'wrong email' }
		end
	end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
	def sign_up_params
		params.permit(:email, :password, :password_confirmation, :name, :access_token, :type)
	end

	def rand_string(len)
		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
		string  =  (0..len).map{ o[rand(o.length)]  }.join
		return string
	end 


end