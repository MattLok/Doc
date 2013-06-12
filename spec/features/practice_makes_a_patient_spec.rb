require 'spec_helper'



feature "creating a patient" do

  it "practice creates a patient" do

    @prac = Practice.create(:office_name => "CCMD", :email => "mmmm@mm.com", :contact_name => "Matt",:phone =>"5083621609")
    visit(new_practice_patient_path(@prac))
         
    fill_in "First name", with:"Carl"
    fill_in "Last name", with:"Banks"
    fill_in "Ssn", with:"1234"
    

    page.status_code.should be 200


  end


  it "checks if practice_membership has been formed on creation" do

    count = PracticeMembership.count
    @prac = Practice.create!(:office_name => "CCMD", :email => "mmmm@mm.com", :contact_name => "Matt",:phone =>"5083621609")
    visit(new_practice_patient_path(@prac))
         
    fill_in "First name", with:"Carl"
    fill_in "Last name", with:"Banks"
    fill_in "Ssn", with:"1234"

    click_on "Create Patient"


    expect(PracticeMembership.count).to eql((count+1))


  end

end