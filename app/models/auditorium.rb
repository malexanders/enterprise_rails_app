class Auditorium < ActiveRecord::Base
  belongs_to :theatre

  validates_presence_of :theatre, :seats_available
  validates :theatre_id, uniqueness: { scope: :auditorium_identifier }
  validate :validate_auditorium_identifier_length

  private

  def validate_auditorium_identifier_length
    if auditorium_identifier.length <= 0
      errors.add 'auditorium_identifier',
                 'must be greater than zero'
    end
  end
end
