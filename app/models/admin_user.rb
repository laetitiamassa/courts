class AdminUser < ActiveRecord::Base

	after_create { |admin| admin.send_reset_password_instructions }
	def password_required?
	  new_record? ? false : super
	end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
