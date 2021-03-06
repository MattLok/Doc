require 'spec_helper'

feature "Referrals" do

  # As practice admin I want to see my practice referrals
  let!(:prac_manager) {FactoryGirl.create(:prac_with_manager)}

  it "can view an index of all referrals" do
    @admin = prac_manager.users.first
    sign_in_as(@admin)
    click_link('Referrals')
    expect(page).to have_content("Doctors")

  end

end
