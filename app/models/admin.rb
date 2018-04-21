class Admin < User
	# validates_presence_of :name
  # validates :type, presence: { message: "must be normal or admin" }
  has_many :libraries, foreign_key: "created_by"
end