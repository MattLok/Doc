# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection do
    requestor_id 1
    target_id 1
    status_type 1
  end
end
