# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :practice do
    contact_name 'samwell'
    email 'samwell@doctor.com'
    office_name 'CC Doctors Office'
    phone '5082604171'
  
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


  # factory :practice2 do
  #   contact_name 'Jon'
  #   email 'Jon@snowdoctor.com'
  #   office_name 'Doc of the North'
  #   phone '5082604444'

  #   factory :practice2_with_doc do 
  #     ignore do
  #       doc_count 1
  #     end

  #     after(:create) do |practice,evaluator|
  #       FactoryGirl.create_list(:doctor, evaluator.doc_count, practice2: practice)
  #     end
  #   end

  # end


end
