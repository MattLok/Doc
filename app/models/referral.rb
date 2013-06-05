class Referral < ActiveRecord::Base
  attr_accessible :from_doctor, :notes, :patient_id, :status_id, :to_doctor
end
