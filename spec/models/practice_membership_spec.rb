require 'spec_helper'

describe PracticeMembership do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "create a PracticeMembership" do

    it {should validate_presence_of(:patient_id) }
    it {should validate_presence_of (:practice_id) }

  end

  describe "PracticeMembership relations" do


    it {should belong_to(:patient) }
    it {should belong_to(:practice) }

  end

end
