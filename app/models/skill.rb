class Skill < ActiveRecord::Base
	belongs_to :user
	belongs_to :prefered_area
end
