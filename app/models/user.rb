class User < ActiveRecord::Base

  BARS = ["Arlon", "BrusselsFR", "BrusselsNL", "Charleroi", "Dinant", "Eupen", "Huy", "Liege", "Marche", "Mons", "Namur", "Neufchateau", "Nivelles", "Tournai", "Verviers", "Anvers", "Brugge", "Dendermonde", "Gent", "Hasselt", "Ieper", "Kortrijk", "Leuven", "Mechelen", "Oudernaarde", "Tongeren", "Turnhout", "Veurne"]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courts
  has_many :questions
  has_many :answers

  def full_name
  	"#{first_name} #{last_name}"
  end

  def full_address
  	"#{street} #{street_number} #{zipcode} #{city}"
  end

  def street_and_number
  	"#{street} #{street_number}"
  end

  def zipcode_and_city
  	"#{zipcode} #{city}"
  end

  def self.bars
    BARS.map do |bar|
      [I18n.t("bars.#{bar}"), bar]
    end
  end
end
