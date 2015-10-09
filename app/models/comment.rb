class Comment < ActiveRecord::Base
	after_create :notification_of_a_new_comment

	belongs_to :court
	belongs_to :loco
	belongs_to :user


	def notification_of_a_new_comment
		
		if self.user ==  self.loco.user
			Notification.create(
				notifiable_type: "Comment",
				notifiable_id: self.id,
				notifier: self.user,
				notifiee: self.loco.court.user,
				message: "Me #{self.user.last_name_or_placeholder} a ajouté un commentaire à votre conversation",
				read: false
			)
		elsif self.user == self.loco.court.user
			Notification.create(
				notifiable_type: "Comment",
				notifiable_id: self.id,
				notifier: self.user,
				notifiee: self.loco.user,
				message: "Me #{self.user.last_name_or_placeholder} a ajouté un commentaire à votre conversation",
				read: false
			)
		end
		
	end
end
