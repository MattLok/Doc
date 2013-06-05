class Referral < ActiveRecord::Base
  attr_accessible :doctor_id, :notes, :patient_id, :status_id, :to_doctor

  belongs_to :doctor 
  has_one :patient 
  has_one :status 


end
