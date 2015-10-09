class Loco < ActiveRecord::Base
	after_create :notification_to_loco, :notification_to_other_respondants
	after_save :notification_to_eval_from_loco_to_dl, :notification_to_eval_from_dl_to_loco
	has_many :notifications, :as => :notifiable

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

	def notification_to_loco
		
		Notification.create(
		      notifier: self.court.user,
		      notifiable_type: "Loco",
		      notifiable_id: self.id,
		      notifiee: self.user,
		      message: "Me #{self.court.user.last_name_or_placeholder} a accepté votre proposition de remplacement",
		      read: false
		    )	
	end

	def notification_to_other_respondants
		
		self.court.responses.each do |response|
			unless self.user.id == response.user.id
			    Notification.create(
			      notifier: self.court.user,
			      notifiable_type: "Loco",
			      notifiable_id: self.id,
			      notifiee: response.user,
			      message: "Me #{self.court.user.last_name_or_placeholder} a choisi un autre confrère pour assurer son remplacement",
			      read: false
			    )
			end
		end
	end

	def notification_to_eval_from_loco_to_dl
			Notification.create(
				notifier: self.court.locos.last.user,
				notifiable_type: "Loco",
				notifiable_id: self.id,
				notifiee: self.court.user,
				message: "Me #{self.court.locos.last.user.last_name_or_placeholder} vous invite à évaluer sa prestation de remplacement",
				read: false,
				created_at: self.court.date.to_datetime
			)
	end

	def notification_to_eval_from_dl_to_loco
		Notification.create(
				notifier: self.court.user,
				notifiable_type: "Loco",
				notifiable_id: self.id,
				notifiee: self.court.locos.last.user,
				message: "Me #{self.court.user.last_name_or_placeholder} vous invite à évaluer votre expérience de remplacement",
				read: false,
				created_at: self.court.date.to_datetime
			)
	end

end
