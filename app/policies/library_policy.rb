class LibraryPolicy < ApplicationPolicy
  class Scope 

	attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve      
    	if user        
	    	if user.has_role?("admin")          
	    		scope.all
	    	else          
	      		scope.where(created_by: @user.try(:id))
	      	end          
	    else        
	    	scope.all
	    end
    end
  end

  def new? ; user_is_owner_of_record? ; end

  def create? 	
    if admin?
      admin?
    elsif normal?          
      false
    end
  end

  def show?
  	if admin?
      admin?
    elsif normal?          
      normal?
    end
  end

  def update?
  	if admin?
      admin?
    elsif normal?          
      normal?
    end 
  end

  def destroy?
  	if admin?
      admin?
    elsif normal?          
      false
    end 
  end

  private

  def user_is_owner_of_record?
  	@user == @record.user  	
  end



end
