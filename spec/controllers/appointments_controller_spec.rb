require 'spec_helper'

describe AppointmentsController do

  #Testing for practice_admin functionality
  let!(:prac_manager) {FactoryGirl.create(:prac_with_manager)}

  it "can visit an index page" do 
    @admin = prac_manager.users.first
    #binding.pry
    sign_in_as(@admin)
    save_and_open_page
    #visit practice_appointments_path(prac_manager)
    click_link('Appointments')
    #puts page.html
    #
    expect(page).to have_content("Upcoming Appointments")

  end

end
