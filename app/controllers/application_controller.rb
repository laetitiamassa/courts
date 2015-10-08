class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def subscribed_user
    redirect_to unsubscribed_path, notice: "Vous devez devenir membre pour bénéficier de cette fonctionnalité" if current_user.overdue
  end

  before_action :set_locale

 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end



	def default_url_options(options = {})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  

end
