require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"


  describe "creating a docotor" do

    it "validates with and without a practice" do

      User.new(:email => "doc@doctor.com",:password =>"password", :first_name => "M", :last_name =>"Test")

      FactoryGirl.create(:user)
      expect(User.count).to eql(1)

      FactoryGirl.create(:practice)
      FactoryGirl.create(:user_belongs)

      expect(User.count).to eql(2)
      #Doctor.new(:email => "doc@doctor.com", :first_name => "M", :last_name =>"Test")

    end

  end

  describe "doctor relationships" do 

    # it "has a practice id when applicable" do

    #   FactoryGirl.create(:doctor_belongs)
    #   doc = Doctor.last
    #   expect(doc.practice_id).to eql(1)


    # end
    it { should belong_to(:practice) }
    it { should have_many(:appointments) }
    it { should have_many(:referrals) }




  end
end
