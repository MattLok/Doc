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

  #Find all of the doctors for connected practices, filtering out docs from current practice
  def connected_docs

    @doctor = Doctor.find(self.doctor_id)
    @practice = Practice.find(@doctor.practice_id)
    @connections = Connection.find(:all, 
        :conditions =>["(requestor_id = ? OR target_id = ?) AND status_type = ?",
        @practice.id, @practice.id, "Accepted"])
    
    @connected_docs = []
    
    @connections.each do |connection|
      @connected_docs << Doctor.find(:all, 
        :conditions =>["(practice_id = ? OR practice_id = ?) AND practice_id != ?", 
        connection.target_id, 
        connection.requestor_id,
        @practice.id]) #this line removes current practice from query
    end
    #binding.pry
    
    @connected_docs.flatten.uniq

  end

end
