require 'spec_helper'

feature "Signing up a practice" do

  #As a visitor
  #I want to be able to sign up a practice
  #So I can start managing my referrals
  # - Visitor clicks on create practice
  # - is expected to sign up as a user
  # - is redirected to create and join a new practice


  it "creates a user then a redirects to practice creation" do
    visit(root_path)
    click_on "Register"

    fill_in 'First name', with:'Matt'
    fill_in 'Last name', with:'Mdog'
    fill_in 'Email', with:'Matt@site.com'
    fill_in 'user_password', with:'password'
    fill_in 'user_password_confirmation', with:'password'

    click_on 'Create User'

    visit(new_practice_path)

    expect(page).to have_content("New Practice")

    fill_in 'Office name', with: 'Dr.x Office'
    fill_in 'Contact name', with: 'Sherryl'
    fill_in 'Phone', with: "3234445454"
    fill_in 'practice[email]', with: 'sherryl@drx.com'

    click_on 'Create Practice'

    expect(page).to have_content("Practice Created")

  end
end
