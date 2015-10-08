class Response < ActiveRecord::Base
	after_create :create_notification
	has_many :notifications, :as => :notifiable

	belongs_to :court
	belongs_to :user

	def create_notification
		
		Notification.create(
		      notifier: self.user,
		      notifiable_type: "Response",
		      notifiable_id: self.id,
		      notifiee: self.court.user,
		      message: "Me #{self.user.last_name_or_placeholder} a répondu à votre demande de remplacement",
		      read: false
		    )	
	end
end
