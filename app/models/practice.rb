class Practice < ActiveRecord::Base
  attr_accessible :contact_name, :email, :office_name, :phone

  has_many :connections
  has_many :users
  has_many :practice_memberships
  has_many :patients, :through => :practice_memberships
  has_many :appointments, :through => :users

  validates_presence_of :office_name
  validates_presence_of :contact_name
  validates_presence_of :email
  validates_presence_of :phone

  validates_format_of :email, with: /@/




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



end
