class UserMailer < ActionMailer::Base
  layout 'mail'
  default from: "Courts <contact@courts.be>"

  def new_court_in_my_bar(court, users_concerned) #envoyé à tout utilisateur inscrit au barreau concerné par la publication
    @court = court
    mail(
    	:bcc => users_concerned.map(&:email),
    	:subject => t("mailer.new_court_in_my_bar.subject")
    	)
  end

  def after_court_creation(court, user) #envoyé au dominus litis qui vient de lancer sa demande de remplacement
  	@court = court
  	@user = @court.user
  	mail(
  		:to => user.email,
  		:subject => t("mailer.after_court_creation.subject")
  		)
  end


  # def weekly(email)
  #   mail(
  #     :to => email,
  #     :subject => "Des audiences, cette semaine ?"
  #     )
  # end

  # def testing(me)
  #   @me = me
  #   mail(
  #     :to => me,
  #     :subject => "testons cela"
  #     )
  # end

  # def new_test(me)
  #   @me = me
  #   mail(
  #     :to => me,
  #     :subject => "testons aussi cela"
  #     )
  # end



end
