class SubscribersController < ApplicationController

	before_filter :authenticate_user!, :only => [:update]
	

	def new
	end

	def update
		token = params[:stripeToken]
		plan_name = params[:planName]
		#current_period_start = params[:current_period_start]
		#current_period_end = params[:current_period_end]
		#cancel_at_period_end = params[:cancel_at_period_end]

		customer = Stripe::Customer.create(
			card: token,
			#plan: plan_name,
			email: current_user.email,
			#cancel_at_period_end: true if plan_name == "1530"
			)

		subscription = customer.subscriptions.create({
			:plan => plan_name
			})

		if plan_name == "1530"
		  subscription.delete({
		  	:at_period_end => true
		  	})
		end

		current_user.subscribed = true
		current_user.subscription_start_date = Time.now
		current_user.plan = plan_name
		current_user.stripeid = customer.id
		current_user.subscription_id = subscription.id
		current_user.save

		redirect_to root_path, notice: "Félicitations, vous êtes maintenant abonné à Courts.be !"
	end

	def unsubscribed
	end


end
