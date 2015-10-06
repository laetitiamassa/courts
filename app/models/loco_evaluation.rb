class LocoEvaluation < ActiveRecord::Base
	belongs_to :court
	belongs_to :user #c'est celui qui évalue (dominus litis)

	def evaluator #celui qui évalue, c'est le dominus litis (qui a créé le court)
		court.user
	end

	def evaluatee #celui qui est évalué, c'est le loco (remplaçant)
		court.locos.last.user
	end
end


