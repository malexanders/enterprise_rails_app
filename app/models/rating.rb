class Rating < ActiveRecord::Base
  validate :validate_length_rating_name

  private

  def validate_length_rating_name
    if rating_name.length <= 0
      errors.add 'rating_name',
                 'must be greater than zero'
    end
  end
end
