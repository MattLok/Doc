require 'spec_helper'

describe Patient do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "creating a patient" do

    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_numericality_of(:ssn)}

  end

  describe "patient relations" do

    it {should have_many(:practice_memberships) }
    it {should have_many(:appointments).through(:practice_memberships)}
    it {should have_one(:referral)}

  end
end
