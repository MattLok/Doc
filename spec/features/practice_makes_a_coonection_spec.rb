require 'spec_helper'

feature "Practice sends a connection request" do 


  it "sends a request to another practice" do

    count = Connection.all.count 
    @prac1 = FactoryGirl.create(:practice)
    @prac2 = Practice.create!(:contact_name => "Gary", :email =>"gary@office.com", :office_name => "Connect MD", :phone => "9783214561")

    visit(new_practice_connection_path(@prac1))

    select('Connect MD', :from => "connection_target_id")

    click_on "Send Connection Request"

    expect(Connection.all.count).to eql(count+1)

  end

  it "can accept a practice request" do

    count = Connection.all.count 
    @prac1 = FactoryGirl.create(:practice)
    @prac2 = Practice.create!(:contact_name => "Gary", :email =>"gary@office.com", :office_name => "Connect MD", :phone => "9783214561")

    visit(new_practice_connection_path(@prac1))
    select('Connect MD', :from => "connection_target_id")
    click_on "Send Connection Request"    

    visit(practice_connections(@prac2))
    click_on "Accept"

    page.should have_content("Your practices are now connected.")

  end

  
end