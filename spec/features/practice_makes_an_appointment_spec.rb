require 'spec_helper'

feature "Practice Creates an appointment" do


  it "creates an appointment" do

    @prac = FactoryGirl.create(:prac_with_manager) #,:practice_with_doc)
    @prac.patients.create!(:first_name => "Patient",:last_name => "Zero", :ssn => "4455")
    admin = @prac.users.first
    admin.password = 'password'

    sign_in_as(admin)

    count = @prac.appointments.count
    visit(new_practice_appointment_path(@prac))

    select('2013', :from => "appointment_date_1i")
    select('August', :from => "appointment_date_2i")
    select('20', :from => "appointment_date_3i")

    select('Julius', :from => "appointment_user_id")
    select('Patient', :from => "appointment_prac_mem_id")

    click_on "Create Appointment"

    expect(@prac.appointments.count).to eql(count+1)

  end


  it "creates and appointment for a referred patient" do

    @prac = FactoryGirl.create(:prac_with_manager) #,:practice_with_doc)
    @prac2 = FactoryGirl.create(:prac_with_manager)
    @prac2.patients.create!(:first_name => "Patient",:last_name => "Zero", :ssn => "4455")

    admin = @prac.users.first
    admin.password = 'password'

    @user2 = @prac2.users.first
    Referral.create!(:user_id => @user2.id, :to_user => admin.id, :patient_id => @prac2.patients.first.id)
    sign_in_as(admin)

    count = @prac.appointments.count
    visit(new_practice_appointment_path(@prac))

    select('2013', :from => "appointment_date_1i")
    select('August', :from => "appointment_date_2i")
    select('20', :from => "appointment_date_3i")

    select('Julius', :from => "appointment_user_id")
    select('Patient', :from => "appointment_prac_mem_id")

    click_on "Create Appointment"

    expect(@prac.appointments.count).to eql(count+1)




  end


end
