class Appointment < ActiveRecord::Base
  attr_accessible :date, :user_id, :prac_mem_id

  validates_presence_of :date
  validates_presence_of :user_id
  validates_presence_of :prac_mem_id

  belongs_to :practice_membership, :class_name =>"practice_membership", :foreign_key =>"prac_mem_id"
  belongs_to :user 
end
