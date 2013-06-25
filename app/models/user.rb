class User < ActiveRecord::Base
  # Include default devise modules. Others availabl e are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  ROLES = %w{practice_admin doctor}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, 
  attr_accessible :email, :first_name, :last_name, :practice_id, :password, :password_confirmation, :remember_me
  after_initialize :default_values

  validates_presence_of :role, :email, :password 


  
  validates :role, :inclusion => { :in => ROLES}

  belongs_to :practice
  has_many :appointments 
  has_many :referrals

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






  
end
