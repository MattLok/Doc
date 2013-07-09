require 'spec_helper'

feature "Appointments" do

  #Testing for practice_admin functionality
  let!(:prac_manager) {FactoryGirl.create(:prac_with_manager)}

  it "can visit an index page" do
    @admin = prac_manager.users.first
    sign_in_as(@admin)
    click_on('Appointments')
    expect(page).to have_content("Practice Appointments")

  end

end
