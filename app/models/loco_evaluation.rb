class LocoEvaluation < ActiveRecord::Base
	belongs_to :court
	belongs_to :user #c'est celui qui est évalué (loco)

	after_create :notification_of_eval_from_dl_to_loco

	def evaluator #celui qui évalue, c'est le dominus litis (qui a créé le court)
		court.user
	end

	def evaluatee #celui qui est évalué, c'est le loco (remplaçant)
		court.locos.last.user
	end

	def notification_of_eval_from_dl_to_loco
		Notification.create(
			notifiable_type: "LocoEvaluation",
			notifiable_id: self.id,
			notifier: self.evaluator,
			notifiee: self.evaluatee,
			message: "Me #{self.evaluator.last_name_or_placeholder} a évalué votre prestation.",
			read: false
			)
	end
end


