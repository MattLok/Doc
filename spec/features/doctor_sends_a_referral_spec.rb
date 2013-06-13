require 'spec_helper'


feature "Doctor can send referrals" do 


  it "checks for a connected practices" do 

    @prac1 = FactoryGirl.create(:practice_with_doc)
    @prac2 = FactoryGirl.create(:practice_with_doc)

    visit(new_doctor_referral_path(@prac1))


  end


end