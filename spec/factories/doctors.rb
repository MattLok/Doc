# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :doctor do
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    practice_id 1
  end
end
