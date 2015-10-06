class Loco < ActiveRecord::Base
	belongs_to :user
	belongs_to :court
	
	has_many :comments
	has_many :private_documentations

	def members
		[user, court.user]
	end

	def current
		#s'il n'y a pas de loco avec le court_id dont le created_at est plus tard que loco.created_at
		self.where(':court_id = ? AND created_at !>=', true)
	end

end
