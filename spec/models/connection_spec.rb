require 'spec_helper'

describe Connection do
  #pending "add some examples to (or delete) #{__FILE__}"



  describe "Creating a connection" do

    it { should validate_presence_of(:requestor_id) }
    it { should validate_presence_of(:target_id) }
    #it { should validate_presence_of(:status_id) }

    it "has a default status_id" do

      a = FactoryGirl.create(:user)
      b = FactoryGirl.create(:user)

      connection = Connection.create(:requestor_id => a.id, :target_id => b.id)

      expect(connection.status_type).to eql('Pending')

      #puts connection.inspect

    end


  end

  describe "Connection relations" do

    #it {should belong_to(:status) }

    it {should belong_to(:requestor_practice)}
    it {should belong_to(:target_practice)}

  end


end
