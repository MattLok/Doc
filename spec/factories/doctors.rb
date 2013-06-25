# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :multiple do |n|
    "Erving#{n}"
  end
  sequence :multi_email do |n|
    "doctorj#{n}@docs.com"
  end

  factory :user do
    first_name 'Julius'
    last_name { generate(:multiple) } 
    email {generate(:multi_email) }     #'doctorJ@docs.com'
    practice
    password 'password'
    role 'doctor'

    trait :belongs do
      practice_id '1'
    end
    trait :manager do
      role "practice_admin"
    end

    factory :user_belongs, traits: [:belongs]
    factory :practice_manager, traits: [:manager]
    
  end

  
  factory :user2 do 

    first_name 'Brian'
    last_name 'Peppers'
    email 'brian@peppers.com'
    practice
    password 'password'
    role 'doctor'

  end


end
