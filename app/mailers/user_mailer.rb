class UserMailer < ActionMailer::Base
  
  default from: "Courts <contact@courts.be>"

  def new_court_in_my_bar(court, users_concerned)
    @court = court
    mail(
    	:bcc => users_concerned.map(&:email),
    	:subject => t("mailer.new_court_in_my_bar.subject")
    	)
  end

  def after_court_creation(court, user)
  	@court = court
  	@user = @court.user
  	mail(
  		:to => user.email,
  		:subject => t("mailer.after_court_creation.subject")
  		)
  end

  def weekly_audiences(email)
    mail(
      :bcc => email,
      :subject => "Des audiences, cette semaine ?"
      )
  end

  def testing(me)
    @me = me
    mail(
      :to => me,
      :subject => "testons cela"
      )
  end

end
