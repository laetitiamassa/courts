class Comment < ActiveRecord::Base
	belongs_to :court
	belongs_to :loco
	belongs_to :user
end
