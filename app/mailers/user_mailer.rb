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

  def new_response_to_your_court_internal(response, user) #envoyé au dominus litis quand une réponse est créée - diffère selon internal or external court
    @court = response.court
    @user = @court.user
    mail(
      :to => user.email,
      :subject => "Un de vos confrères est disponible pour vous remplacer"
      )
  end

  def new_response_to_your_court_external(response, user)
    @court = response.court
    @external_requester_email = response.court.external_requester_email
    mail(
      :from => "Courts.be | votre outil de remplacement 2.0 <contact@courts.be>",
      :to => @external_requester_email,
      :subject => "Votre demande de remplacement : un de vos confrères est disponible"
      )
  end

  def you_have_been_chosen_as_loco(loco, user) #envoyé au loco choisi quand un loco est créé
    @court = loco.court
    @chosen_loco = @court.locos.last.user
    mail(
      :to => @chosen_loco.email,
      :subject => "Votre confrère vous a choisi pour intervenir loco"
      )
  end

  def another_loco_has_been_chosen #envoyé à chaque répondant non choisi, quand un loco est choisi
  end

  def do_you_need_a_loco(court, user)
    @court = court
    @external_requester_email = court.external_requester_email
    mail(
      :from => "Courts.be | votre outil de remplacement 2.0 <contact@courts.be>",
      :to => @external_requester_email,
      :subject => "Votre audience du #{l @court.date_display, :format => '%e %B'} prochain : trouvez un remplaçant en quelques minutes"
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
