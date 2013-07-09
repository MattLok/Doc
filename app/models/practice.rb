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

    referrals.any? { |referral| referral.user == user }

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
  #checks if patient is in practice
  def has_member?(patient)
    records = PracticeMembership.where("patient_id = ?", patient.id)
    records.pluck(:practice_id).include?(id)


  end

  def accepted_connections
    Connection.where("(requestor_id = ? OR target_id = ?) AND status_type = ?",self.id,self.id,"Accepted")

  end

  def pending_connections

     Connection.where("(requestor_id = ? OR target_id = ?) AND status_type = ?",self.id,self.id,"Pending")

  end

  def potential_connections
    self.class.joins("LEFT OUTER JOIN connections ON
      (practices.id = connections.target_id AND connections.requestor_id = #{self.id}) OR
      (practices.id = connections.requestor_id AND connections.target_id = #{self.id})").
      where('connections.id IS NULL')

  end

  #Filter out nil referrals created on the index page
  def valid_referrals
    referrals.where("user_id IS NOT NULL")
  end

  def most_sent_referrals
    refs = users.each_with_object({}) do |user, hash|
      hash[user.id] = user.referrals.group_by_month("created_at").count
    end
    refs.reject!{|k,v| v == {}}
    if (refs.length == 0)
       "Not Applicable"
    else
      record = Hash[refs.sort_by {|user_id, date_counts| date_counts.values.max }.reverse!].first

      user = User.find(record[0]).full_name
      count = record[1].values[-1]

      stat = "#{user} - #{count}"
    end

  end
  def most_received_referrals
    refs = users.each_with_object({}) do |user, hash|
      hash[user.id] = user.received_referrals.group_by_month("created_at").count
    end
    refs.reject!{|k,v| v == {}}
    if (refs.length == 0)
       "Not Applicable"
    else
      record = Hash[refs.sort_by {|user_id, date_counts| date_counts.values.max }.reverse!].first
      user = User.find(record[0]).full_name
      count = record[1].values[-1]

      stat = "#{user} - #{count}"
    end

  end

  def sender_practices
    senders = User.find(received_referrals.pluck(:user_id))
    pracs = []
    senders.each do |user|
      pracs << user.practice_id
    end
    pracs.collect{|prac| Practice.find(prac)}.uniq

  end

  #Get the practice who has sent you the most referrals this month
  def most_inbound

    inbound = Hash.new
    data = sender_practices.map do |sender|
      if sender.referrals.count == 0
        next
      end
      inbound[sender.office_name] = sender.referrals.group_by_month("referrals.created_at").count
    end
    if (data.length == 0)
       "Not Applicable"
    else
      record = inbound.max_by{|k,v| v.max_by{|k1,v1| [k1,v1]}}
      prac = record[0]
      count = record[1].values[0]

      stat = "#{prac} - #{count}"
    end
  end

  #retrieves all practcememberhsips to be iterated through
  def referred_appointments(opt)
    patients = []
    memberships= []
    opt.each do |ref|
      patients << ref.patient_id
    end

    patients.each do |pat|
      memberships << PracticeMembership.where("(patient_id = ? AND practice_id = ?)",pat,self)
    end
    memberships.flatten.uniq

  end

  def referral_appointments(opt)
    range = Time.now.beginning_of_month..Time.now.end_of_month
    referrals = Hash.new
    data = referred_appointments(opt).map do |member|
      if member.appointments.count == 0
        next
      end
      referrals[member.id] = member.appointments.group_by_month("appointments.created_at", Time.zone, range).count

    end
    referrals.delete_if{|k,v| v.empty?}
    sum = 0
    referrals.values.each do |x|
      sum += x.values[0]
    end
    sum

  end

  def referral_to_appointment_percent(opt)

    received = (referral_appointments(opt)).to_f
    total = appointments.group_by_month("appointments.created_at").count.values[-1].to_f
    percent = (received/total) *100

  end

  #gets all practice patients and ones who have been referred but haven't set up an appointment
  def all_patients
    pats = patients.pluck(:id)
    ref_pats = received_referrals.pluck(:patient_id).uniq
    Patient.find_all_by_id((pats + ref_pats).uniq)

  end


  def self.practices_that_sent_referrals_to(practice)
    Referral.where(to_user: Practice.user_ids).practices
  end
end
