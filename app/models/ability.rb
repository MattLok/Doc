class Ability
  include CanCan::Ability

  def initialize(user)


    user ||= User.new

    if user.practice_admin?
      can :manage, Appointment do |appointment|
        appointment.new_record? || appointment.involves?(user.practice_id) #involves practice_id 
      end
      #can :manage, :all
      can :manage, Connection do |connection|
        connection.new_record? || connection.involves?(user)
        #connection.requestor_id == user.practice_id || connection.target_id == user.practice_id
      end

      can :read, PracticeMembership do |membership|
       #:practice_id => user.practice_id
       membership.involves?(user)
      end
      #can :manage, Patient, :PracticeMembership => { :practice_id => user.practice_id}
      can :manage, Patient do |patient|
        patient.new_record? || patient.in_practice_of?(user)
    
      end
      can :manage, Practice do |practice|

        practice.new_record? || practice.involves?(user)
      end
    elsif user.doctor? 
      can :manage, Referral, :user_id => user.id
     # can :read, :all
      can :read, Connection
      can :read, Appointment, :user_id => user.id 
      # can :read, Appointment, :user_id => user.id
      can :read, PracticeMembership, :practice_id => user.practice_id
      can :read, Practice, :id => user.practice_id
      can :create, Practice 
    else
      can :create, User
      #can :create, Practice
    end
        
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end





