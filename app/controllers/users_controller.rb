class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
  	@user = User.find(params[:id])
    @user_courts = @user.courts.order("date DESC")
  end

  def edit
  	@user = current_user
    @bars = User.bars
  end

  def update
  	@user = User.find(params[:id])
    @bars = User.bars
    if @user.update(user_params)
      redirect_to @user, notice: t("users.well_modified") 
    else
      render action: 'edit', notice: t("users.error")
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :bar, :street, :street_number, :city, :zipcode, :telephone, :fax, :mobile, :dominus_litis, :loco, :subscribed, :extended_trial, :extended_trial_end_date)
  end
end
