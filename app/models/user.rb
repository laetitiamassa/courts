class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courts

  def full_name
  	"#{first_name} #{last_name}"
  end

  def full_address
  	"#{street} #{street_number} #{zipcode} #{city}"
  end

  def street_and_number
  	"#{street} #{street_number}"
  end

  def zipcode_and_city
  	"#{zipcode} #{city}"
  end
end
