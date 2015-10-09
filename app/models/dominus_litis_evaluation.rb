class DominusLitisEvaluation < ActiveRecord::Base
	belongs_to :court
	belongs_to :user #celui qui est évalué (le loco)

	after_create :notification_of_eval_from_loco_to_dl

	def evaluator
		#celui qui évalue le dominus litis, c'est le loco (remplaçant)
		court.locos.last.user
	end

	def evaluatee
		#celui qui est évalué c'est le dominus litis
		court.user
	end

	def notification_of_eval_from_loco_to_dl
		Notification.create(
			notifiable_type: "DominusLitisEvaluation",
			notifiable_id: self.id,
			notifier: self.evaluator,
			notifiee: self.evaluatee,
			message: "Me #{self.evaluator.last_name_or_placeholder} a évalué son expérience de collaboration avec vous.",
			read: false
			)
	end
end
