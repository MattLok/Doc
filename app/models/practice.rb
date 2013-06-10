class Practice < ActiveRecord::Base
  attr_accessible :contact_name, :email, :office_name, :phone

  has_many :connections
  has_many :doctors
  has_many :practice_memberships
  has_many :patients, :through => :practice_memberships
  has_many :appointments, :through => :doctors

  validates_presence_of :office_name
  validates_presence_of :contact_name
  validates_presence_of :email
  validates_presence_of :phone

  validates_format_of :email, with: /@/




end
