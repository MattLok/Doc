class Connection < ActiveRecord::Base
  attr_accessible :requestor_id, :status_id, :target_id
end
