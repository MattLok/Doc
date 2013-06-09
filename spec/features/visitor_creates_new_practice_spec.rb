require 'spec_helper'


feature "creating a new practice" do 

  it "creates a new practice" do

    visit(new_practice_path)

    fill_in "Office", with: "Dr.Doctors Office"
    fill_in "Contact", with: "Doctor. Robotnik"
    fill_in "Phone", with: "5083661234"
    fill_in "Email", with:"doc@doctors.com"

    #expect(page).to have_content "Dr.Doctors Office"
    #expect(page).to have_content "Here is the practice page" 
    page.status_code.should be 200
  end


end