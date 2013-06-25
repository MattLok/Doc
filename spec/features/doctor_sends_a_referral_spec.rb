require 'spec_helper'


feature "Doctor can send referrals" do 
    let!(:prac1){FactoryGirl.create(:practice_with_doc)}
    #let!(:prac2){FactoryGirl.create(:practice_with_doc2)}

  it "checks for a connected practices" do 


    count = Referral.all.count
    prac1.patients.build(:first_name => "Pat",:last_name => "Lamp", :ssn => 1900)
    prac1.save

    prac2 = Practice.create!(:office_name =>"Office",:contact_name =>"Sue",:phone =>"3453432345", :email =>"2d@d.com")
    prac2.users.create!(:first_name => "Robin",:last_name =>"X", :email=> "mm@w.com",:password =>"password")#, :role =>'doctor')
    @doc = prac1.users.first
    @doc2 = prac2.users.first 

   @a= Connection.create!(:requestor_id => prac1.id, :target_id => prac2.id, :status_type => "Accepted")
   #binding.pry
    #@doc2.first_name = 'Robin'
    #@doc2.save!
    #puts @doc2.first_name
    #puts @a

    
    #puts doc.id

    visit(new_doctor_referral_path(@doc))
    #save_and_open_page
    select('Robin', :from => "referral_to_user")
    select('Pat', :from => "referral_patient_id")
    
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
