FactoryGirl.define do
  factory :theatre do
    sequence(:id) { |number| number }
    name "Scotia Bank"
    address_line_1 "Dundas"
    address_line_2 ""
    address_city "Toronto"
    address_state "ON"
    address_zip_code "M6G 2N6"
    phone_number "2312122323"
  end
end
