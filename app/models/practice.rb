class Practice < ActiveRecord::Base
  attr_accessible :contact_name, :email, :office_name, :phone

  has_many :connections
  has_many :doctors
  has_many :patients, :through => :practice_membership
  has_many :appointments, :through => :doctors

  


end
