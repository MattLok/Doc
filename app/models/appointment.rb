class Appointment < ActiveRecord::Base
  attr_accessible :date, :user_id, :prac_mem_id

  validates_presence_of :date
  validates_presence_of :user_id
  validates_presence_of :prac_mem_id

  belongs_to :practice_membership, :class_name =>"practice_membership", :foreign_key =>"prac_mem_id"
  belongs_to :user 



  def involves?(user)
    user.practice.appointments.include?(self)

    #user.practice == appointment.practice_membership.practice 
  end

  def doctor_name
    @doc = User.find(self.user_id)
    @name = "#{@doc.first_name} #{@doc.last_name}" 

  end
  def patient_name
    @record = PracticeMembership.find(self.prac_mem_id) 
    @patient = Patient.find(@record.patient_id) 
    @name = "#{@patient.first_name} #{@patient.last_name}"

  end
end
