class Doctor < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :practice_id
end
