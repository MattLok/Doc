class Ability
  include CanCan::Ability

  def initialize(user)


    user ||= User.new

    if user.practice_admin?
      can :manage, Appointment do |appointment|
        appointment.new_record? || appointment.involves?(user.practice) #involves practice_id
      end
      can :manage, Connection do |connection|
        connection.new_record? || connection.involves?(user)
      end

      can :read, PracticeMembership do |membership|
       membership.involves?(user)
      end
      can :manage, Patient do |patient|
        patient.new_record? || patient.in_practice_of?(user)
      end
      can :manage, Practice do |practice|

        practice.new_record? || practice.involves?(user)
      end
      can :read, Referral do |referral|
        referral.involves?(user)
      end
    elsif user.doctor?
      can :manage, Referral, :user_id => user.id
      can :read, Connection
      can :read, Appointment, :user_id => user.id
      can :read, PracticeMembership, :practice_id => user.practice_id
      can :read, Practice, :id => user.practice_id
      can :create, Practice
    else
      can :create, User
    end

  end
end





