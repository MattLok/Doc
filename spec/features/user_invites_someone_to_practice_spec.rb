require 'spec_helper'


feature "Sending invite" do 

  #As a practice_admin
  #  I want to be able to send doctors in my practice invitations to the service
  #   So I can begin tracking their referrals 
  include EmailSpec::Helpers

  it "emails an invitation to user" do 
    @prac = FactoryGirl.create(:prac_with_manager)
    admin = @prac.admins.first
    sign_in_as(admin)
    mail = "FudgeDragons@yahoo.com"
    #binding.pry

    click_on("Send Invite")

    fill_in "user_email", with: mail
    click_button "Send an invitation"

    expect(page).to have_content("An invitation email has been sent")
    
  end

  it "accepts an invitation" do
    pending "email spec debugging"
    open_email(mail)
    #open_last_email_for(mail)
    visit_in_email("Accept invitation")
    save_and_open_page
    #click_on "Accept invitation
  end
end
