require 'spec_helper'

feature "Practice sends a connection request" do 

  #let!(:prac_manager) {FactoryGirl.create(:prac_manager)}  

    it "sends a request to another practice" do

      count = Connection.all.count 
      
      @prac1 = FactoryGirl.create(:prac_with_manager)
      @prac2 = FactoryGirl.create(:prac_with_manager)
      admin = @prac1.users.first
      admin.password = 'password'
      sign_in_as(admin)
      expect(page).to have_content("Signed in successfully")

      visit(new_practice_connection_path(@prac1))

      select(@prac2.office_name, :from => "connection_target_id")

      click_on "Send Connection Request"

      expect(Connection.all.count).to eql(count+1)

    end

    it "can accept a practice request" do

      @prac1 = FactoryGirl.create(:prac_with_manager)
      @prac2 = FactoryGirl.create(:prac_with_manager)
      admin = @prac1.users.first
      admin2 = @prac2.users.first 
      admin.password ='password'
      admin2.password='password'
      sign_in_as(admin)

      visit(new_practice_connection_path(@prac1))
     
      select(@prac2.office_name, :from => "connection_target_id")
      click_on "Send Connection Request"
      click_on 'Sign out'
      expect(page).to have_content("Signed out successfully")
      ##### Log in with second user and accept the connection request
      sign_in_as(admin2)    

      visit(practice_connections_path(@prac2))
      save_and_open_page
      click_on "Accept"

      page.should have_content("You are now connected")

    end


    it "shows the Office name of the practice making the request" do 
      @prac1 = FactoryGirl.create(:practice)
      @prac2 = Practice.create!(:contact_name => "Gary", :email =>"gary@office.com", :office_name => "Connect MD", :phone => "9783214561")

      @connection = Connection.create!(:requestor_id => @prac1.id, :target_id => @prac2.id)

      expect(@connection.requestor_name).to eql(@prac1.office_name)

    end

    it "doesn't show connections that are no longer pending" do
      @prac1 = FactoryGirl.create(:prac_with_manager)
      @prac2 = FactoryGirl.create(:prac_with_manager)
      admin = @prac1.users.first
      admin.password= 'password'
      admin2 = @prac2.users.first
      admin2.password = 'password'
      sign_in_as(admin)
      visit(new_practice_connection_path(@prac1))
      select(@prac2.office_name, :from => "connection_target_id")
      click_on "Send Connection Request"
      click_on 'Sign out'

      #sign in as second user
      sign_in_as(admin2)
      visit(practice_connections_path(@prac2))
      click_on "Decline"
      page.should have_content("You rejected them...")

      visit(practice_connections_path(@prac2))
      page.should have_content("No pending connections at this time")


    end

  
end
