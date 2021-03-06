class User < ActiveRecord::Base

  ROLES = %w{practice_admin doctor}

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :first_name, :last_name, :practice_id, :password, :password_confirmation, :remember_me
  after_initialize :default_values

  validates_presence_of :role, :email, :password



  validates :role, :inclusion => { :in => ROLES}

  belongs_to :practice
  has_many :appointments
  has_many :referrals
  has_many :received_referrals,
    class_name: 'Referral',
    foreign_key: 'to_user'

  before_save :default_values
  def default_values
    self.role ||= 'doctor'
  end

  def practice_admin?
    self.role == 'practice_admin'
  end

  def doctor?
    self.role == 'doctor'
  end

  def has_practice?
    practice.present?
  end

  def make_admin
    self.update_attribute(:role, 'practice_admin')
  end

  def full_name

    @name = "#{self.first_name} #{self.last_name}"
  end

  def received_referrals_from(practice)
    refs = received_referrals
    from_prac_doctor = refs.where(user_id: practice.user_ids)

  end

  def valid_referrals
    referrals.where("user_id IS NOT NULL")
  end

end
