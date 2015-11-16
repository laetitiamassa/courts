class User < ActiveRecord::Base

  #after_create :right_path

  BARS = ["Arlon", "BrusselsFR", "BrusselsNL", "Charleroi", "Dinant", "Eupen", "Huy", "Liege", "Marche", "Mons", "Namur", "Neufchateau", "Nivelles", "Tournai", "Verviers", "Anvers", "Brugge", "Dendermonde", "Gent", "Hasselt", "Ieper", "Kortrijk", "Leuven", "Mechelen", "Oudernaarde", "Tongeren", "Turnhout", "Veurne"]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  
  has_many :courts
  has_many :responses
  has_many :locos
  has_many :comments
  has_many :loco_evaluations
  has_many :dominus_litis_evaluations

  has_many :confirmations

  has_many :documentations
  has_many :private_documentations

  has_many :skills
  has_many :prefered_areas, :through => :skills
  
  has_many :questions
  has_many :answers

  has_many :notifications_as_notifier, :class_name=> 'Notification', :foreign_key => 'notifier_id'
  has_many :notifications_as_notifiee, :class_name=> 'Notification', :foreign_key => 'notifiee_id'

  has_attached_file :avatar, 
                    :styles => { large: "320x420#", medium: "300x300#", thumb: "100x100#", mini: "50x50#", rikiki: "35x35#" }, 
                    :default_url => ":style/missing.jpeg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


#COURTS TO SEE
  def current_courts_count
      current_courts_count = 0
      Court.active.each do |court|
        if court.current && !court.infirmed
          current_courts_count += 1
        end
      
      end 
      current_courts_count
  end



#SUBSCRIPTIONS, INVITATIONS AND ACCESS

# USER STATUS

  def status
    if subscribed
      subscribed
    elsif on_trial
      on_trial
    elsif on_free
      on_free
    else
      overdue
    end
  end

# TRIAL PERIOD

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

  # def trial_end_date
  #   unless early_bird
  #     if extended_trial
  #       extended_trial_end_date
  #     end
  #   else
  #     created_at + 15.days
  #   end 
  # end

  def trial_end_date
    if extended_trial
      extended_trial_end_date
    elsif created_by_invite? && invitation_accepted_at.present?
      invitation_accepted_at + 15.days
    else
      created_at + 15.days
    end
  end

  def trial_start_date
    if created_by_invite?
      invitation_accepted_at
    else
      created_at
    end
  end

  def days_till_end_trial
      ((trial_end_date - Time.now) / 1.day).round
  end

  def not_yet
    sign_in_count < 1
  end



# ACCESS STATUS

  def subscribed_or_on_trial_or_on_free
    if subscribed
      subscribed
    elsif on_trial
      on_trial
    elsif on_free
      on_free
    end
  end

  def subscribed_or_on_trial
    if subscribed
      subscribed
    else
      on_trial
    end
  end
  
  def overdue
    !on_trial && !subscribed 
  end

  def has_active_access
    Time.now < next_billing_date_including_free_months
  end

# PLANS

  def plan_name_display
    if subscribed
      if plan == "1530"
        "Courts One Week" 
      elsif plan == "1520"
        "Courts Monthly"
      elsif plan == "1510"
        "Courts Yearly"
      #else
        #"Courts Yearly" #parce que les users payants jusqu'à présent sont sous Courts Yearly
      end
    elsif on_trial
      "en période d'essai"
    elsif overdue
      "Aucun abonnement"
    end
  end

  def subscription_start_date_or_placeholder
    if subscription_start_date # le user s'est inscrit et a une date de souscription
      subscription_start_date
    elsif on_trial # le user est en période d'essai depuis son arrivée ou son acceptation d'invitation
      trial_start_date
    else #le user a dépassé la période d'essai et est en overdue
      trial_start_date
    end    
  end

  def subscription_end_date_or_placeholder
    if plan_end_date
      plan_end_date
    elsif subscribed
      subscription_start_date_or_placeholder + billing_duration
    elsif on_trial
      trial_end_date
    else
      trial_end_date
    end
  end

# FREE PERIOD

  def on_free
    Time.now < free_months_period_end_date
  end

  def free_months_period_end_date
    if accepted_invitations_count >= 1
      free_months_period_start_date + free_months_period_in_months
    else
      free_months_period_start_date
    end
  end

  def free_months_period_in_months
    if accepted_invitations_count > 12
      12.months
    elsif accepted_invitations_count <= 12
      accepted_invitations_count.months
    end
  end

  def free_months_period_in_months_display
    free_months_period_in_months / 1.month
  end

  def free_months_period_start_date
    if overdue && accepted_invitations_count >= 1
      self.invitations.where.not('invitation_accepted_at IS ?', nil).first.invitation_accepted_at
    else
      subscription_end_date_or_placeholder
    end
  end


# BILLINGS

  def billing_duration
    if plan == "1530"
      1.week 
    elsif plan == "1520"
      1.month
    elsif plan == "1510"
      1.year
    else
      1.second
    end
  end

  def next_billing_date
    if billing_duration
      subscription_start_date_or_placeholder + billing_duration
    else
      subscription_start_date_or_placeholder
    end
  end

  def next_billing_date_including_free_months
      free_months_period_end_date
  end

  

#INVITATIONS

  def accepted_invitations_count
    accepted_invitations_count = 0
    self.invitations.each do |invitation|
      unless invitation.invitation_accepted_at.blank?
        accepted_invitations_count += 1
      end
    end
    accepted_invitations_count
  end

#USER NOTIFICATIONS
  def open_notifications_count
    all_open_notifications_count - delayed_open_notifications_count #toutes les notifications à l'exceptions de celles dont le user ne doit pas être averti
  end

  def all_open_notifications_count
    self.notifications_as_notifiee.where(:read => false).count
  end

  def delayed_open_notifications_count
    delayed_open_notifications_count = 0
    self.notifications_as_notifiee.where(:read => false).each do |notif|
      if notif.message.include? "invite" #si c'est une notification d'invitation à évaluer
        if notif.notifiable.court.current #tant que le court est passé, et que donc le user ne doit pas encore être averti
          delayed_open_notifications_count += 1
        end
      end
    end
    delayed_open_notifications_count
  end

#USER STATS

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

#USER PROFILE

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

  def is_power_user
    self.email == "laetitiamassa@gmail.com" #"lol@lol.com"
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

def send_devise_notification(notification, *args)
  if :invitation_instructions == notification
    args << {
      from: "#{invited_by.name_or_placeholder} via Courts.be <contact@courts.be>",
      subject: I18n.t("devise.mailer.invitation_instructions.subject", :name => invited_by.name_or_placeholder)
    }
  end
  super
end


end
