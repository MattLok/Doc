class Doctor < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :practice_id


  belongs_to :practice
  has_many :appointments 
  has_many :referrals

  
end
