class SubscribersController < ApplicationController

	before_filter :authenticate_user!
	

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
			plan: plan_name,
			email: current_user.email,
			#cancel_at_period_end: true if plan_name == "1530"
			)

		current_user.subscribed = true
		current_user.subscription_start_date = Time.now
		current_user.plan = plan_name
		#current_user.plan_start_date = current_period_start #(pas nécessaire car on rallonge)
		#current_user.plan_end_date = current_period_end + current_user.free_months_period_in_months
		current_user.stripeid = customer.id
		current_user.save

		redirect_to root_path, notice: "Félicitations, vous êtes maintenant abonné à Courts.be !"
	end

	def unsubscribed
	end


end
