FactoryGirl.define do
  factory :auditorium do
    association :theatre
    auditorium_identifier "Most Beautiful Auditorium"
    seats_available 500
  end
end
