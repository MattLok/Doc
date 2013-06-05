class Referral < ActiveRecord::Base
  attr_accessible :from_doctor, :notes, :patient_id, :status_id, :to_doctor

  belongs_to :doctor 
  has_one :patient 
  has_one :status 


end
