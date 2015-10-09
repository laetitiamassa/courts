class Court < ActiveRecord::Base
	after_create :create_notification
	after_update :notification_to_respondants

	BARS = ["Arlon", "BrusselsFR", "BrusselsNL", "Charleroi", "Dinant", "Eupen", "Huy", "Liege", "Marche", "Mons", "Namur", "Neufchateau", "Nivelles", "Tournai", "Verviers", "Anvers", "Brugge", "Dendermonde", "Gent", "Hasselt", "Ieper", "Kortrijk", "Leuven", "Mechelen", "Oudernaarde", "Tongeren", "Turnhout", "Veurne"]

	belongs_to :user
	has_many :responses
	has_many :locos
	has_one :loco_evaluation
	has_one :dominus_litis_evaluation
	has_many :documentations

	has_many :notifications, :as => :notifiable

	
	validates :performance, presence: true
	validates :jurisdiction, presence: true
	validates :bar, presence: true

	scope :active, lambda {where('date >= ?', Time.now)}

	def self.bars
	    BARS.map do |bar|
	      [I18n.t("bars.#{bar}"), bar]
	    end
	end

	def current #workaround datetimepicker not set to UTC
		date_display - 2.hours >= Time.now
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

	def create_notification
	    @users_in_bar = User.where(:bar => self.bar)
		
		@users_in_bar.each do |user|
		    Notification.create(
		      notifier: self.user,
		      notifiable_type: "Court",
		      notifiable_id: self.id,
		      notifiee: user,
		      message: "Me #{self.user.last_name_or_placeholder} recherche un remplaçant",
		      read: false
		    )
		end
	end

	def notification_to_respondants

		self.responses.each do |response|
			Notification.create(
				notifier: self.user,
				notifiable_type: "Court",
				notifiable_id: self.id,
				notifiee: response.user,
				message: "Me #{self.user.last_name_or_placeholder} a modifié sa demande de remplacement",
				read: false
			)
		end
	end

	

end
