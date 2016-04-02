class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :async 
         
         validate :email_is_unique, on: :create
         after_create :create_account

         def confirmation_required?
         	true
         end


         private
         # Email should be uniqe in Accaount Model
         def email_is_unique
         	# email should be unique in account model this is 
         	# to not revalidate account from user and devise showing the 
         	# same error twice
         	return false unless self.errors[:email].empty?

         	unless Account.find_by_email(email).nil?
         		errors.add(:email,'is already taken private says')
         	end
         end

         def create_account
         	account=Account.new(:email=>email)
         	account.save
         end
end
