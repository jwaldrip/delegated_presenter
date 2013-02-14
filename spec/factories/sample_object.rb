FactoryGirl.define do

  factory :sample_object do
    prefix      "Dr."
    first_name  "John"
    middle_name "Patrick"
    last_name   "Doe"
    suffix      "M.D."
  end

  factory :inherited_sample_object do
    prefix      "Mrs."
    first_name  "Jane"
    middle_name "Marie"
    last_name   "Smith"
    suffix      "Esq."
  end

end