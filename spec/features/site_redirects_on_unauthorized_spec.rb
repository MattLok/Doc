require 'spec_helper'


feature "Site redirects" do

  it "redirects to when accessing pages when user is unauthorized" do 
    @prac = FactoryGirl.create(:prac_with_manager)
    visit(new_practice_appointment_path(@prac))

    expect(page).to have_content("You are not authorized to access this page.")

  end


end
