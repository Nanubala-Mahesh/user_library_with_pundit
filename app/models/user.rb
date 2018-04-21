class User < ActiveRecord::Base
  devise :invitable, :invalidatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable

    validates_presence_of :name
    
	def has_role?(role_in_question)
        type == role_in_question.capitalize.to_s
    end  

	def force_logout
		self.user_sessions.update_all(:session_id => nil)
	end
end
