class Connection < ActiveRecord::Base
  attr_accessible :requestor_id, :status_type, :target_id
  after_initialize :default_values

  validates_presence_of :requestor_id
  validates_presence_of :target_id
  validates_presence_of :status_type

  belongs_to :requestor_practice, :class_name => "Practice", :foreign_key => "requestor_id"
  belongs_to :target_practice, :class_name => "Practice", :foreign_key => "target_id"


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

  def sender_or_receiver(user)
    if self.requestor_id == user.practice_id
      target_practice
    elsif self.target_id == user.practice_id
      requestor_practice
    end
  end

end
