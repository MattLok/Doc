# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referral do
    from_doctor 1
    to_doctor 1
    patient_id 1
    notes "MyText"
    status_id 1
  end
end
