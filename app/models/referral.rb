class Referral < ActiveRecord::Base
  attr_accessible :doctor_id, :notes, :patient_id, :status_type, :to_doctor
  after_initialize :default_values

  validates_presence_of :doctor_id
  validates_presence_of :patient_id
  validates_presence_of :status_type
  validates_presence_of :to_doctor

  belongs_to :doctor 
  belongs_to :patient 
  #has_one :status 

  $REFERRAL_STATUS = ['Sent','Received']

  def default_values
    self.status_type ||= $REFERRAL_STATUS[0]
    self.notes ||= "No notes specified"

  end


end
