class Theatre < ActiveRecord::Base
  has_many :movie_showtimes, :dependent => :destroy

  acts_as_address
end

