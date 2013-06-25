require 'spec_helper'
require 'cancan/matchers'


describe "User" do 
  describe "abilities" do 

    #subject {ability}
    # /let(:ability) {Ability.new(user)}
    # let(:user){nil}
    # /
    pending "when is a practice manager" do 
      let(:user){FactoryGirl.create(:practice_manager)}

      it{ should be_able_to(:manage, Appointment.new())}

    end
  end
end

