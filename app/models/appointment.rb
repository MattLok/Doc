class Appointment < ActiveRecord::Base
  attr_accessible :date, :doctor_id, :prac_mem_id
end
