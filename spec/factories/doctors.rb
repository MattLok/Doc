# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :multiple do |n|
    "Erving#{n}"
  end

  factory :doctor do
    first_name 'Julius'
    last_name { generate(:multiple) } 
    email 'doctorJ@docs.com'
    practice

    trait :belongs do
      practice_id '1'
    end

    factory :doctor_belongs, traits: [:belongs]
    
  end


  factory :doctor2 do 

    first_name 'Brian'
    last_name 'Peppers'
    email 'brian@peppers.com'
    practice

  end

end
