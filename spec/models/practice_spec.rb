require 'spec_helper'

describe Practice do
  #pending "add some examples to (or delete) #{__FILE__}"


  describe "creating a practice" do 


    it "doesn't create until all fields are present" do
      Practice.create(:office_name => "Cape Cod MD", :email => "m@ccmd.com")

      expect(Practice.count).to  eql(0)
    end

    it "checks for presence of @ in email" do

      Practice.create(:office_name => "CCMD", :email => "mmmmmm", :contact_name => "Matt",:phone =>"5083621609")

      expect(Practice.count).to eql(0)
    end


  end


  describe "practice relations" do
    

    it "has doctors in the practice" do 
      #FactoryGirl.create(:practice)
      prac = FactoryGirl.create(:practice_with_docs)
      #puts prac
      #puts prac.id
      expect(prac.users.count).to eql(5)
    end



  end
end
