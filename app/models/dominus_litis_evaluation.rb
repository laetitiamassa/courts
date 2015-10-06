class DominusLitisEvaluation < ActiveRecord::Base
	belongs_to :court
	belongs_to :user #celui qui évalue (le loco)

	def evaluator
		#celui qui évalue le dominus litis, c'est le loco (remplaçant)
		court.locos.last.user
	end

	def evaluatee
		#celui qui est évalué c'est le dominus litis
		court.user
	end
end
