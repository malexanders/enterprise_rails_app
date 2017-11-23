class Theatre < ActiveRecord::Base
  has_many :movie_showtimes
end

