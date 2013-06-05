class Appointment < ActiveRecord::Base
  attr_accessible :date, :doctor_id, :prac_mem_id

  belongs_to :practice_membership
  belongs_to :doctor 
end
