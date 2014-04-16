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

end
