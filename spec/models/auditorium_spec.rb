require 'rails_helper'

RSpec.describe Auditorium, type: :model do
  context "Database Layer Validations", database_specs: true do
    it "validates auditorium_identifier is at least 1 char in length" do
      auditorium = build :auditorium, auditorium_identifier: ""
      test_for_db_error "Database allowed save with auditorium_identifier with length 0" do
        auditorium.save(validate: false)
      end
    end

    it "validates the presence of theatre id" do
      auditorium = build :auditorium, theatre_id: nil
      test_for_db_error "Database allowed save without theatre id" do
        auditorium.save(validate: false)
      end
    end

    it "validates the presence of seats_available" do
      auditorium = build :auditorium, seats_available: nil
      test_for_db_error "Database allowed save without seats_available" do
        auditorium.save(validate: false)
      end
    end

    it "validates uniqueness of theatre_id and autitorium_identifier combination" do
      auditorium_1 = create :auditorium
      auditorium_2 = build :auditorium, theatre_id: auditorium_1.theatre.id
      test_for_db_error "Database allowed save with duplicate theatre_id and autitorium_identifier combination" do
        auditorium_2.save(validate: false)
      end
    end

    it "validates valid theatre association" do
      auditorium_2 = build :auditorium, theatre_id: 100
      test_for_db_error "Database allowed save with invalid theatre" do
        auditorium_2.save(validate: false)
      end
    end
  end

  context "Application Layer Validations" do
    it "validates auditorium_identifier is at least 1 char in length" do
      auditorium = build :auditorium, auditorium_identifier: ""
      expect(auditorium.save).to eq(false), "Application allowed save with auditorium_identifier with length 0"
    end

    it "validates the presence of theatre id" do
      auditorium = build :auditorium, theatre_id: nil
      expect(auditorium.save).to eq(false), "Application allowed save without theatre id"
    end

    it "validates the presence of seats_available" do
      auditorium = build :auditorium, seats_available: nil
      expect(auditorium.save).to eq(false), "Application allowed save without seats_available"
    end

    it "validates uniqueness of theatre_id and autitorium_identifier combination" do
      auditorium_1 = create :auditorium
      auditorium_2 = build :auditorium, theatre_id: auditorium_1.theatre.id
      expect(auditorium_2.save).to eq(false), "Application allowed save with duplicate theatre_id and autitorium_identifier combination"
    end

    it "validates valid theatre association" do
      auditorium = build :auditorium, theatre_id: 100
      expect(auditorium.save).to eq(false), "Application allowed save with invalid theatre"
    end
  end
end

