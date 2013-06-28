require 'spec_helper'

describe DoctorsController do

  #as a practice adming I want to see the doctors in my practice
  let!(:prac_manager) {FactoryGirl.create(:prac_with_manager)}

  it "can visit an index page" do 
    @admin = prac_manager.users.first
   
    sign_in_as(@admin)
    click_link('Doctors')
    
    expect(page).to have_content("Doctors")


  end

end
