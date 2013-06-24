require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"


  describe "creating a docotor" do

    it {should validate_presence_of :role}
    it {should ensure_inclusion_of(:role).in_array(%w{practice_admin doctor})}
    it {should_not allow_mass_assignment_of(:role)}

    it "validates with and without a practice" do

      User.new(:email => "doc@doctor.com",:password =>"password", :first_name => "M", :last_name =>"Test")

      FactoryGirl.create(:user)
      expect(User.count).to eql(1)

      FactoryGirl.create(:practice)
      FactoryGirl.create(:user_belongs)

      expect(User.count).to eql(2)
      #Doctor.new(:email => "doc@doctor.com", :first_name => "M", :last_name =>"Test")

    end

    it "has a default role" do 

     doc = User.create!(:email => "doc@doctor.com",:password =>"password", :first_name => "M", :last_name =>"Test")
      #count = User.count
      expect(doc.role).to eql('doctor')
    end

  end

  describe "doctor relationships" do 

    it { should belong_to(:practice) }
    it { should have_many(:appointments) }
    it { should have_many(:referrals) }

  end
end
