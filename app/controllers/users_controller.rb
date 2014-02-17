class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = current_user
    @bars = User.bars
  end

  def update
  	@user = User.find(params[:id])
    @bars = User.bars
    if @user.update(user_params)
      redirect_to @user, notice: 'Your profile was successfully updated.' 
    else
      render action: 'edit', notice: 'try again'
    end
  end

  def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :bar, :street, :street_number, :city, :zipcode, :telephone, :fax, :mobile, :dominus_litis, :loco)
    end
end
