class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :async 
         
         validate :email_is_unique, on: :create
         validate :subdomain_is_unique,on: :create 
         after_validation :create_tenant
         after_create :create_account

         def confirmation_required?
         	true
         end


         private
         # Email should be uniqe in Accaount Model
         def email_is_unique
            if email.present?
                unless Account.find_by_email(email).nil?
                    errors.add(:email,"is already used")
                end
            end
        end
         	   
         # Subdomain should be unique in account model
         def subdomain_is_unique
            if subdomain.present?
                unless Account.find_by_subdomain(subdomain).nil?
                    errors.add(:subdomain,"is already taken")
                end
            # tenant name should not be from the excluded list 
                if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
                    errors.add(:subdomain,"is a reserved subdomain.")
                end
            end
         end

         def create_tenant
            Apartment::Tenant.create(subdomain)
            Apartment::Tenant.switch!(subdomain)
        end



         def create_account
         	account=Account.new(:email=>email,:subdomain=>subdomain)
         	account.save
         end
end
