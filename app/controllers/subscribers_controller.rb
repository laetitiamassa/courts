class SubscribersController < ApplicationController

	before_filter :authenticate_user!
	before_action :set_notifications

	def new
	end

	def update
		token = params[:stripeToken]

		customer = Stripe::Customer.create(
			card: token,
			plan: 1510,
			email: current_user.email
			)

		current_user.subscribed = true
		current_user.stripeid = customer.id
		current_user.save

		redirect_to root_path, notice: "Félicitations, vous êtes maintenant abonné à Courts.be !"
	end

	def unsubscribed
	end

	private

	def set_notifications
      @notifications = Notification.all
      @open_notifications_count = @notifications.where(:notifiee => current_user, :read => false).count - @notifications.where(:notifiee => current_user, :notifier => current_user, :read => false).count - @notifications.where('created_at >= ?', Time.now).count 
    end


end
