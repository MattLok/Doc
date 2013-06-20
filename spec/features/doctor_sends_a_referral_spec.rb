require 'spec_helper'


feature "Doctor can send referrals" do 


  it "checks for a connected practices" do 

    @prac1 = FactoryGirl.create(:practice_with_doc)
    @prac2 = FactoryGirl.create(:practice_with_doc)
    count = Referral.all.count
    @prac1.patients.build(:first_name => "Pat",:last_name => "Lamp", :ssn => 1900)
    @prac1.save
    @doc = @prac1.users.first
    @doc2 = @prac2.users.first 

    Connection.create!(:requestor_id => @prac1.id, :target_id => @prac2.id, :status_type => "Accepted")
    @doc2.first_name = 'Robin'
    @doc2.save
    
    #puts doc.id

    visit(new_user_referral_path(@doc))
    #save_and_open_page

    select('Pat', :from => "referral_patient_id")
    select('Robin', :from => "referral_to_user")
    fill_in 'Notes', with:'This guy is messed up'

    click_on "Send Referral"

    expect(Referral.count).to eql(count+1) 

  end

  # it "Doc without pract can send referral" do 
  #   @prac = FactoryGirl.create(:practice)
  #   @doc = Doctor.create!(:first_name => "Matt", :last_name =>"M",:email => "m@2.com",:practice_id => @prac.id)
  #   #@doc2 = FactoryGirl.create(:doctor)

  #   visit(new_doctor_referral_path(@doc))

  #   select('Leeeeeroooyyy', :from => "referral_patient_id")
  #   select('Julius', :from => "referral_doctor_id")
  #   fill_in 'Notes', with:'This guy is messed up'

  #   click_on "Send Referral"




  # end









end
