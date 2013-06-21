require 'spec_helper'

feature "Practice Creates an appointment" do


  it "creates an appointment" do

    @prac = FactoryGirl.create(:practice_with_doc)
    @prac.patients.create!(:first_name => "Patient",:last_name => "Zero", :ssn => "4455")
    count = @prac.appointments.count
    visit(new_practice_appointment_path(@prac))

    fill_in 'Date', with:'7/4/2013'
    #find_field('appointment_doctor_id').last

    select('Julius', :from => "appointment_user_id")
    select('Patient', :from => "appointment_prac_mem_id")

    click_on "Create Appointment"

    expect(@prac.appointments.count).to eql(count+1)

  end


end
