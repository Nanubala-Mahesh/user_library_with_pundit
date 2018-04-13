class UserPolicy < ApplicationPolicy
	def admin?
		user.has_role?("admin")    
	end

	def normal?
		user.has_role?("normal")    
	end
end