require 'spec_helper'



feature "creating a patient" do

  it "practice creates a patient" do
    @prac = FactoryGirl.create(:prac_with_manager)
    admin = @prac.users.first
    admin.password ='password'
    sign_in_as(admin)
    visit(new_practice_patient_path(@prac))

    fill_in "First name", with:"Carl"
    fill_in "Last name", with:"Banks"
    fill_in "Ssn", with:"1234"

    click_on "Create Patient"

    page.status_code.should be 200
    expect(page).to have_content("Patient Successfully Created")

  end


  it "checks if practice_membership has been formed on creation" do

    count = PracticeMembership.count
    @prac = FactoryGirl.create(:prac_with_manager)
    admin = @prac.users.first
    admin.password ='password'
    sign_in_as(admin)
    visit(new_practice_patient_path(@prac))

    fill_in "First name", with:"Carl"
    fill_in "Last name", with:"Banks"
    fill_in "Ssn", with:"1234"

    click_on "Create Patient"

    expect(PracticeMembership.count).to eql((count+1))

  end

  it "can create a patient on the index page" do

    @prac = FactoryGirl.create(:prac_with_manager)
    admin = @prac.users.first
    sign_in_as(admin)
    visit(practice_patients_path(@prac))

    fill_in "First name", with: "Rick"
    fill_in "Last name", with: "Johnson"
    fill_in "Ssn", with:"5231"

    click_on "Create Patient"

    expect(page).to have_content("Patient Successfully Created")



  end

end
