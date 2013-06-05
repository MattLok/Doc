class Connection < ActiveRecord::Base
  attr_accessible :requestor_id, :status_id, :target_id

  belongs_to :practice
  has_one :status

end
