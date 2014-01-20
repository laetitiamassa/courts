class Court < ActiveRecord::Base
	belongs_to :user

	scope :active, where('date >= ?', Time.now)
end
