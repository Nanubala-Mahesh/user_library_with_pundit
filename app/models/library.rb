class Library < ActiveRecord::Base
	require 'csv'

	belongs_to :admin, foreign_key: "created_by"
	belongs_to :normal, foreign_key: "created_by"
	belongs_to :user, foreign_key: "created_by"

	validates_uniqueness_of :ref_id

	before_create do
		self.ref_id = SecureRandom.hex if self.ref_id.nil?		
	end



	def self.import(file)

		CSV.foreach(file.path, headers: true) do |row|
			# binding.pry
			library = Library.new
			library.ref_id = row[0]
			library.purchased_on = Date.today 
			library.in_possession_of = row[2] 
			library.description = row[3]
			
			if library.save
			
			else
				@errors = [ ]
				library.errors.full_messages.each do |row,message|
					@errors << "#{message} at #{row}"
				end
			end 
			
			@errors #  <- need to return the @errors array 
		end
		puts @errors
	end


end
