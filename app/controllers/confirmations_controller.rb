class ConfirmationsController < InheritedResources::Base

  def create
  	@confirmation = current_user.confirmations.build(confirmation_params)
  	@court = @confirmation.court

  	respond_to do |format|
      if @confirmation.save
        #envoyer notifications to each potential loco qui n'a pas répondu déjà
        if @confirmation.confirmed
	  		UserMailer.new_court_in_my_bar(@court, users_in_bar).deliver if has_users_in_bar?
	  	end


  		if @confirmation.confirmed
	  		@court.update_attributes(:is_external => false, :to_confirm => false, :confirmed_at => Time.now, :internalized_at => Time.now)
	  	elsif @confirmation.infirmed
	  		@court.update_attributes(:is_external => false, :to_confirm => false, :infirmed => true, :infirmed_at => Time.now)
	  	end


	  	if @confirmation.confirmed
	        format.html { redirect_to court_path(@court), notice: "Votre demande de remplacement est bien confirmée. Vous pouvez choisir parmi vos confrères disponibles." }
	    elsif @confirmation.infirmed
	    	format.html { redirect_to root_path, notice: "Merci pour votre réponse. Cette demande de remplacement est maintenant désactivée." }
	    end

        format.json { render action: 'show', status: :created, location: @court }
      else
        format.html { render action: 'new' }
        format.json { render json: @confirmation.errors, status: :unprocessable_entity }
      end
    end	
  end

  #users_in_bar
    def users_in_bar
      User.where(:bar => @court.bar) #.where.not(id: current_user) 
    end 

    def has_users_in_bar?
      users_in_bar.any?
    end

  private

    def confirmation_params
      params.require(:confirmation).permit(:court_id, :user_id, :confirmed, :infirmed)
    end
end

