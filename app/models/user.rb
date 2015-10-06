class User < ActiveRecord::Base

  BARS = ["Arlon", "BrusselsFR", "BrusselsNL", "Charleroi", "Dinant", "Eupen", "Huy", "Liege", "Marche", "Mons", "Namur", "Neufchateau", "Nivelles", "Tournai", "Verviers", "Anvers", "Brugge", "Dendermonde", "Gent", "Hasselt", "Ieper", "Kortrijk", "Leuven", "Mechelen", "Oudernaarde", "Tongeren", "Turnhout", "Veurne"]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :courts
  has_many :responses
  has_many :locos
  has_many :comments
  has_many :loco_evaluations
  has_many :dominus_litis_evaluations

  has_many :documentations
  has_many :private_documentations

  has_many :skills
  has_many :prefered_areas, :through => :skills
  
  has_many :questions
  has_many :answers

  has_attached_file :avatar, 
                    :styles => { large: "320x420#", medium: "300x300#", thumb: "100x100#", mini: "50x50#" }, 
                    :default_url => ":style/missing.jpeg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  
  def loco_count
    loco_count = 0
    locos.each do |loco|
      if loco.court.locos.last.user.id == self.id
        loco_count += 1
      end
    end 
    loco_count
  end

  def reco_count
    loco_reco_count + dl_reco_count
  end

  def loco_reco_count
    loco_reco_count = 0
    locos.each do |loco|
      if loco.court.loco_evaluation
        if loco.court.loco_evaluatee.id == self.id && loco.court.loco_evaluation.evaluation == "happy"
          loco_reco_count += 1
        end
      end
    end
    loco_reco_count
  end

  def dl_reco_count
    dl_reco_count = 0
    courts.each do |court|
      if court.dominus_litis_evaluation
        if court.dominus_litis_evaluatee.id == self.id && court.dominus_litis_evaluation.evaluation == "happy"
          dl_reco_count += 1
        end
      end
    end
    dl_reco_count
  end

  def full_name
  	"#{first_name} #{last_name}"
  end

  def name_or_placeholder
    if full_name.present?
      full_name
    else
      email.split("@")[0]
    end
  end

  def firstname_or_placeholder
    if first_name.present?
      first_name
    else
      email.split("@")[0]
    end
  end

  def last_name_or_placeholder
    if last_name.present?
      last_name
    else
      email.split("@")[0]
    end
  end

  def first_name_or_email
    if first_name.present?
      first_name
    else
      email
    end
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

  def early_bird
    created_at < "2015-02-27 00:00:00"
  end

  def on_trial
    if early_bird
      Time.now < "2015-04-06 00:00:00"
    elsif extended_trial
      Time.now < extended_trial_end_date
    else 
      Time.now - created_at < 15.days
    end
  end

  def subscribed_or_on_trial
    if subscribed
      subscribed
    else
      on_trial
    end
  end

  def trial_end_date
    unless early_bird
      if extended_trial
        extended_trial_end_date
      else
        created_at + 15.days
      end
    end
  end

  def overdue
    !on_trial && !subscribed
  end

  def days_till_end_trial
      ((trial_end_date - Time.now) / 1.day).round
  end

  def not_yet
    sign_in_count < 1
  end

# email hebdomadaire audiences
  def self.weekly
    @users = User.all
    @users.each do |u|
      UserMailer.weekly(u.email).deliver
    end
  end

# email test
  def self.testing
    @me = "laetitiamassa@gmail.com"
    UserMailer.testing(@me).deliver
  end

# new test
  def self.new_test
    @me = "contact@appstratgram.com"
    UserMailer.new_test(@me).deliver
  end



end
