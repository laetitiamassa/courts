class Court < ActiveRecord::Base

	BARS = ["Arlon", "BrusselsFR", "BrusselsNL", "Charleroi", "Dinant", "Eupen", "Huy", "Liege", "Marche", "Mons", "Namur", "Neufchateau", "Nivelles", "Tournai", "Verviers", "Anvers", "Brugge", "Dendermonde", "Gent", "Hasselt", "Ieper", "Kortrijk", "Leuven", "Mechelen", "Oudernaarde", "Tongeren", "Turnhout", "Veurne"]

	belongs_to :user

	
	validates :performance, presence: true
	validates :jurisdiction, presence: true
	validates :bar, presence: true

	scope :active, where('date >= ?', Time.now)

	def self.bars
    BARS.map do |bar|
      [I18n.t("bars.#{bar}"), bar]
    end
  end

end
