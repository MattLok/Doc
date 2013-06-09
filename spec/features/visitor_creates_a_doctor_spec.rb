require 'spec_helper'


feature "creating a doctor" do
  
  it "creates a new doctor" do
    prac = Practice.create(:office_name => "CCMD", :email => "mmmmmm", :contact_name => "Matt",:phone =>"5083621609")
    visit(new_doctor_path)

    fill_in "First name", with:"Testy"
    fill_in "Last name", with:"Doc"
    fill_in "Email", with:"testy@practice.com"
    fill_in "Practice", with:"#{prac.id}" 

    page.status_code.should be 200

  end


end