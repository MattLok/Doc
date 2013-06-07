require 'spec_helper'

describe Referral do
  #pending "add some examples to (or delete) #{__FILE__}"


  describe "creating a referral" do 

    it {should validate_presence_of(:doctor_id)}
    it {should validate_presence_of(:patient_id)}
    it {should validate_presence_of(:status_id)}
    it {should validate_presence_of(:to_doctor)}


    it "has a default status_id" do

      doc = FactoryGirl.create(:doctor)
      doc2 = FactoryGirl.create(:doctor)
      pat = FactoryGirl.create(:patient)

      ref = Referral.create(:doctor_id => doc.id,:patient_id => pat.id,:to_doctor => doc.id)

      expect(ref.status_id).to eql(1)

    end

    it "has a default note if none specified" do
      doc = FactoryGirl.create(:doctor)
      doc2 = FactoryGirl.create(:doctor)
      pat = FactoryGirl.create(:patient)

      ref = Referral.create(:doctor_id => doc.id,:patient_id => pat.id,:to_doctor => doc.id)

      expect(ref.notes).to eql("No notes specified")

    end

  end


  describe "referral relations" do



  end
end
