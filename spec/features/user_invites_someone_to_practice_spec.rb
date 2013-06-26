require 'spec_helper'


feature "Sending invite" do 

  #As a practice_admin
  #  I want to be able to send doctors in my practice invitations to the service
  #   So I can begin tracking their referrals 

  it "emails an invitation to user" do 
    @prac = FactoryGirl.create(:prac_with_manager)
    admin = @prac.admins.first
    sign_in_as(admin)
    #binding.pry

    click_on("Send Invite")

    fill_in "user_email", with: "FudgeDragons@yahoo.com"
    save_and_open_page
    click_button "Send an invitation"

    expect(page).to have_content("An invitation email has been sent")


  end



end
