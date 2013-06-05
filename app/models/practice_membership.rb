class PracticeMembership < ActiveRecord::Base
  attr_accessible :patient_id, :practice_id

  belongs_to :patient_id
  belongs_to :practice 
end
