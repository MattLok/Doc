class Status < ActiveRecord::Base
  attr_accessible :type

  belongs_to :referral
  belongs_to :connection
end
