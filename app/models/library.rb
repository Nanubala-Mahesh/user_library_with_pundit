class Library < ActiveRecord::Base
	belongs_to :admin, foreign_key: "created_by"
	belongs_to :normal, foreign_key: "created_by"
	belongs_to :user, foreign_key: "created_by"


	before_create do
		self.ref_id = SecureRandom.hex		
	end
end
