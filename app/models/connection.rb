class Connection < ActiveRecord::Base
  attr_accessible :requestor_id, :status_type, :target_id
  after_initialize :default_values

  validates_presence_of :requestor_id
  validates_presence_of :target_id
  validates_presence_of :status_type 

  

  #belongs_to :practice
  #has_one :status
  #has_one :status #, :class_name => "status", :foreign_key => "status_id"
  #belongs_to :status

  #A belongs to target(target_id) : A belongs to requestor
  # Class name and foreign key options
  # class in both cases is going to be the same 

  belongs_to :practice, :class_name => "practice", :foreign_key => "requestor_id"
  belongs_to :practice, :class_name => "practice", :foreign_key => "target_id"

  $STATUSES = ['Pending','Accepted','Declined']

  before_save :default_values
  def default_values
    self.status_type ||= $STATUSES[0]
  end

  def requestor_name
    @requestor = Practice.find(self.requestor_id)
    @requestor.office_name
  end

  def target_name 
    @sender = Practice.find(self.target_id)
    @sender.office_name
  end

  def get_name(user)
    if self.requestor_id == user.practice_id 
      target_name 
    elsif self.target_id == user.practice_id 
      requestor_name
    end
  end

  def involves?(user)
    self.requestor_id == user.practice_id || self.target_id == user.practice_id


  end


end
