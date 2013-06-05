# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :doctor do
    first_name 'Julius'
    last_name 'Erving'
    email 'doctorJ@docs.com'
    practice

    trait :belongs do
      practice_id '1'
    end

    factory :doctor_belongs, traits: [:belongs]
    
  end

end
