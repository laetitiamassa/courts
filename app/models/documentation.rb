class Documentation < ActiveRecord::Base
	after_create :notification_to_court_respondants

	belongs_to :court
	belongs_to :user

	has_attached_file :document
	validates_attachment :document, 
						 :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

	def notification_to_court_respondants
		self.court.responses.each do |response|
			Notification.create(
				notifier: self.user,
				notifiable_type: "Documentation",
				notifiable_id: self.id,
				notifiee: response.user,
				message: "Me #{self.user.last_name_or_placeholder} a ajouté un document à sa demande de remplacement",
				read: false
			)
		end
	end
end
