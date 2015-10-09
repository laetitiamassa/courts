class PrivateDocumentation < ActiveRecord::Base
	after_create :notification_of_a_new_private_document

	belongs_to :loco
	belongs_to :user

	has_attached_file :document
	validates_attachment :document, 
						 :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

	def notification_of_a_new_private_document
		
		if self.user ==  self.loco.user
			Notification.create(
				notifiable_type: "PrivateDocumentation",
				notifiable_id: self.id,
				notifier: self.user,
				notifiee: self.loco.court.user,
				message: "Me #{self.user.last_name_or_placeholder} a ajouté un document privé à votre conversation",
				read: false
			)
		elsif self.user == self.loco.court.user
			Notification.create(
				notifiable_type: "Comment",
				notifiable_id: self.id,
				notifier: self.user,
				notifiee: self.loco.user,
				message: "Me #{self.user.last_name_or_placeholder} a ajouté un document privé à votre conversation",
				read: false
			)
		end
		
	end
end
