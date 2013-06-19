require 'spec_helper'

describe 'authentication' do 
  let!(:doctor) {FactoryGirl.create(:doctor) }

  it "can sign into an account" do 

    visit new_doctor_session_path
    fill_in "Email", with:doctor.email
    fill_in "Password", with:doctor.password

    click_button 'Sign in'

    #save_and_open_page
    expect(page).to have_content("Signed in successfully")

  end

  it "cant sign out of an account" do 
    visit new_doctor_session_path 
    fill_in "Email", with:doctor.email
    fill_in "Password", with:doctor.password

    click_button 'Sign in'
    click_on 'Sign out'

    expect(page).to have_content("Signed out successfully")

  end

end