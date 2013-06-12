class PracticeMembership < ActiveRecord::Base
  attr_accessible :patient_id, :practice_id

  validates_presence_of :patient_id
  validates_presence_of :practice_id


  belongs_to :patient
  belongs_to :practice


  def get_first_name

    self.patient.first_name

  end 
end
 