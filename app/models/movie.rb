class Movie < ActiveRecord::Base
  has_many :movie_showtimes, :dependent => :destroy

  validates_presence_of :name, :rating, :length_minutes
  validates_uniqueness_of :name
  validates_length_of :name, :maximum => 256
  validates_numericality_of :length_minutes, :only_integer => true
  validate :validate_length_minutes, :validate_rating_type

  VALID_RATINGS = ['Unrated', 'G', 'PG', 'PG-13', 'R', 'NC-17']

  def validate_length_minutes
    if length_minutes && length_minutes <= 0
      errors.add 'length_minutes',
                 'must be greater than zero'
    end
  end

  def validate_rating_type
    if !VALID_RATINGS.include?(rating)
      errors.add 'rating',
                 "must be #{VALID_RATINGS[0..-2].join(', ')} or #{VALID_RATINGS[-1]}"
    end
  end
end


