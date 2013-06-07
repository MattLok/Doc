require 'spec_helper'

describe Status do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "creating a status" do
    it {should validate_presence_of :status_type}


  end

  describe "status relations" do
    it {should have_many :referrals}
    it {should have_many :connections}

  end



end
