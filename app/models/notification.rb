class Notification < ActiveRecord::Base
	belongs_to :notifier, :class_name => 'User', :foreign_key => 'notifier_id'
	belongs_to :notifiee, :class_name => 'User', :foreign_key => 'notifiee_id'
	belongs_to :notifiable, :polymorphic => true

	def created_at_display
		if message.include? "invite"
			created_at #workaround in dev: created_at - 2.hours
		else
			created_at
		end
	end
end
