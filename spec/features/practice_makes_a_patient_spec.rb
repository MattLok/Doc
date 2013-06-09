require 'spec_helper'



feature "creating a patient" do

  it "practice creates a patient" do

    @prac = Practice.create(:office_name => "CCMD", :email => "mmmm@mm.com", :contact_name => "Matt",:phone =>"5083621609")
    visit(new_practice_patient_path)
         
    fill_in "First name", with:"Carl"
    fill_in "Last name", with:"Banks"
    

    page.status_code.should be 200


  end

end