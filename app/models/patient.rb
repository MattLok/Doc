class Patient < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :ssn

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_numericality_of :ssn

  has_many :practice_memberships
  has_many :appointments, :through => :practice_memberships
  has_one  :referral
  
end
