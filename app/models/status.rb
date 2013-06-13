class Status < ActiveRecord::Base
  attr_accessible :status_type

  validates_presence_of :status_type

  has_many :referrals
  #has_many :connections
end
