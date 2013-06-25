# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :multi_practice do |n|
    "CC Doctors Office#{n}"
  end

  factory :practice do
    contact_name 'samwell'
    email 'samwell@doctor.com'
    office_name {generate(:multi_practice)}
    phone '5082604171'

    trait :practice_with_manager do 
      ignore do
        doc_count 1
      end
      
      after(:create) do |practice,evaluator|
        FactoryGirl.create_list(:practice_manager, evaluator.doc_count, practice: practice)
      end
    end
    factory :prac_with_manager ,traits: [:practice_with_manager]
  
    factory :practice_with_docs do 
      ignore do 
        doc_count 5
      end

      after(:create) do |practice,evaluator|
        FactoryGirl.create_list(:user, evaluator.doc_count, practice: practice)
      end
    end

    factory :practice_with_doc do
      ignore do
        doc_count 1
      end

      after(:create) do |practice,evaluator|
        FactoryGirl.create_list(:user, evaluator.doc_count, practice: practice)
      end
    end
     
  end

end
