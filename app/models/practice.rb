class Practice < ActiveRecord::Base
  attr_accessible :contact_name, :email, :office_name, :phone, :users_attributes


  has_many :connections_as_requestor,
    class_name: 'Connection',
    foreign_key: 'requestor_id'

  has_many :connections_as_target,
    class_name: 'Connection',
    foreign_key: 'target_id'
  has_many :users
  has_many :admins,
    class_name: "User",
    conditions: { role: "practice_admin" }
  has_many :practice_memberships
  has_many :patients, :through => :practice_memberships
  has_many :appointments, :through => :users
  has_many :referrals, :through => :users
  has_many :received_referrals, :through => :users,
    class_name: 'Referral',
    foreign_key: 'to_user'

  validates_presence_of :office_name
  validates_presence_of :contact_name
  validates_presence_of :email
  validates_presence_of :phone

  validates_format_of :email, with: /@/
  accepts_nested_attributes_for :users

  def involves?(user)
    # users.any? do |user|
    referrals.any? { |referral| referral.user == user }
    # end
  end


  def referrals_count(sent="to_user",timeframe = 365)

    @docs = User.where("practice_id = ?", self.id)
    @referrals = []
    @docs.each do |doc|
      @referrals << Referral.find(:all,:conditions =>["(#{sent} = ?)
        AND (created_at <= ? AND created_at >= ?)",
        doc.id,(Date.today+10.days), (Date.today-timeframe.days)])
    end
    @referrals.flatten
  end

  def involves?(user)
    self.id == user.practice_id
  end

  def all_practice_docs

    @docs = User.where("practice_id = ?", self.id)

  end

  def accepted_connections
    Connection.where("(requestor_id = ? OR target_id = ?) AND status_type = ?",self.id,self.id,"Accepted")

  end

  def pending_connections

     Connection.where("(requestor_id = ? OR target_id = ?) AND status_type = ?",self.id,self.id,"Pending")

  end

  def potential_connections
    # joins(:connections_as_requestor, :connections_as_target).where("connections.target_id != ? ")
    self.class.joins("LEFT OUTER JOIN connections ON
      (practices.id = connections.target_id AND connections.requestor_id = #{self.id}) OR
      (practices.id = connections.requestor_id AND connections.target_id = #{self.id})").
      where('connections.id IS NULL')

  end

end
