class Patient < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :ssn, :fullname

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_numericality_of :ssn

  has_many :practice_memberships
  has_many :appointments, :through => :practice_memberships

  has_one  :referral

  def in_practice_of?(user)

    if user.practice.present?
      practice = user.practice
      practice.has_member?(self)
    end

  end

  def form_full_name(practice)

    if PracticeMembership.where("practice_id = ? AND patient_id = ?", practice.id, id).count > 0
      @fullname ||= "#{self.first_name} #{self.last_name}"
    else
      @fullname ||= "#{self.first_name} #{self.last_name} - Referred"
    end
  end

  def full_name
    @fullname ||= "#{self.first_name} #{self.last_name}"
  end

end
