class RegistrationsController < Devise::RegistrationsController

  # helper_method :practice

  # def new
  #   # @practice.users.build
  #   # user = build_resource
  #   # @practice.users << user
  #   # @practice.users.build
  #   # resource = build_resource({})
  #   # respond_with resource
  #   super
  # end

    # def create
    #   binding.pry

    #   else render action: "new"
    # end

  # protected
  # def build_resource(hash=nil)
  #   user_attributes =  if params[:practice].present?
  #     params[:practice].delete(:users_attributes)["0"]
  #   else
  #     {}
  #   end

  #   hash ||= params[:practice] || {}

  #   self.resource = Practice.new(hash)

  #   if user_attributes.present?
  #     user = User.new_with_session(user_attributes, session)
  #   else
  #     user = User.new_with_session({}, session)
  #   end

  #   resource.users << user

  #   binding.pry
  #   resource
  # end

  # def practice
  #   @practice ||= Practice.new
  # end
end
