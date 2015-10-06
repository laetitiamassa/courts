class Court < ActiveRecord::Base

	BARS = ["Arlon", "BrusselsFR", "BrusselsNL", "Charleroi", "Dinant", "Eupen", "Huy", "Liege", "Marche", "Mons", "Namur", "Neufchateau", "Nivelles", "Tournai", "Verviers", "Anvers", "Brugge", "Dendermonde", "Gent", "Hasselt", "Ieper", "Kortrijk", "Leuven", "Mechelen", "Oudernaarde", "Tongeren", "Turnhout", "Veurne"]

	belongs_to :user
	has_many :responses
	has_many :locos
	has_one :loco_evaluation
	has_one :dominus_litis_evaluation
	has_many :documentations

	
	validates :performance, presence: true
	validates :jurisdiction, presence: true
	validates :bar, presence: true

	scope :active, lambda {where('date >= ?', Time.now)}

	def self.bars
	    BARS.map do |bar|
	      [I18n.t("bars.#{bar}"), bar]
	    end
	end

	def current
		date_display >= Time.now
	end

	def past
		!current
	end

	def loco_lawyer
		if locos.any?
			locos.last.user
		end
	end

	def date_display
		
			date.to_datetime
		
	end

	def loco_evaluator
		loco_evaluation.evaluator
	end

	def loco_evaluatee
		loco_evaluation.evaluatee
	end

	def dominus_litis_evaluator
		dominus_litis_evaluation.evaluator
	end

	def dominus_litis_evaluatee
		dominus_litis_evaluation.evaluatee
	end

	def current
		date >= Time.now 
	end

end
