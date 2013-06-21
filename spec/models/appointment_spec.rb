require 'spec_helper'

describe Appointment do
  #pending "add some examples to (or delete) #{__FILE__}"


  describe "creating an appointment" do

    it {should validate_presence_of(:date) }
    it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:prac_mem_id)}


  end

  describe "appointment relations" do

    it {should belong_to(:practice_membership)}
    it {should belong_to(:user)}

  end
end
