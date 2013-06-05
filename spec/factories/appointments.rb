# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :appointment do
    date "2013-06-05 10:35:48"
    doctor_id 1
    prac_mem_id 1
  end
end
