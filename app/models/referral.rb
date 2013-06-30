class Referral < ActiveRecord::Base
  attr_accessible :user_id, :notes, :patient_id, :status_type, :to_user
  after_initialize :default_values

  validates_presence_of :user_id
  validates_presence_of :patient_id
  validates_presence_of :status_type
  validates_presence_of :to_user

  belongs_to :user 
  belongs_to :patient 

  #has_one :status 

  $REFERRAL_STATUS = ['Sent','Received']

  def default_values
    self.status_type ||= $REFERRAL_STATUS[0]
    self.notes ||= "No notes specified"

  end

  #Find all of the doctors for connected practices, filtering out docs from current practice
  def connected_docs

    @doctor = User.find(self.user_id)
    @practice = Practice.find(@doctor.practice_id)
    @connections = Connection.find(:all, 
        :conditions =>["(requestor_id = ? OR target_id = ?) AND status_type = ?",
        @practice.id, @practice.id, "Accepted"])
    
    @connected_docs = []
    
    @connections.each do |connection|
      @connected_docs << User.find(:all, 
        :conditions =>["(practice_id = ? OR practice_id = ?) AND practice_id != ?", 
        connection.target_id, 
        connection.requestor_id,
        @practice.id]) #this line removes current practice from query
    end
    #binding.pry
    
    @connected_docs.flatten.uniq

  end

  def involves?(user)
    #self.requestor_id == user.practice_id || self.target_id == user.practice_id
    user.practice.referrals.include?(self) || user.practice.received_referrals.include?(self)
  end


  #grab all referrals that belong to specific practice 
  #first need to check if the doctor belongs to the practice 


  def get_name(name = "user_id")
    #binding.pry
    if name == "user_id"
      @user = User.find(self.user_id)
    else
      @user = User.find(self.to_user)
    end
    @name = "#{@user.first_name} #{@user.last_name}"
  end

  def patient_name
    @record = PracticeMembership.where("patient_id = ? ", self.patient_id).first 
    @patient = Patient.find(@record.patient_id)
    @name = "#{@patient.first_name} #{@patient.last_name}"

  end






end
