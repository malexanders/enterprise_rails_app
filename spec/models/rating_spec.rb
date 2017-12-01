require 'rails_helper'

RSpec.describe Rating, type: :model do
  context "Database Layer Validations", database_specs: true do
    it "validates rating name is at least 1 char in length" do
      st = build :rating, rating_name: ""
      test_for_db_error "Database allowed save with rating_name with length 0" do
        st.save(validate: false)
      end
    end
  end

  context "Application Layer Validations" do
    it "validates rating name is at least 1 char in length" do
      rating = build :rating, rating_name: ""
      expect(rating.save).to eq(false), "Application allowed save with rating_name with length 0"
    end
  end
end
