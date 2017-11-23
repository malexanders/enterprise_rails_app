require 'rails_helper'

RSpec.describe Movie, type: :model do
  def test_for_db_error(error_message, &block)
    begin
      yield
    rescue ActiveRecord::StatementInvalid
      database_threw_error = true
    rescue
      something_else_threw_error = true
    end
    expect(!something_else_threw_error).to be(true), "There is an error in our test code"
    expect(database_threw_error && !something_else_threw_error).to be(true), error_message
  end

  it "enforces name not null" do
    movie = Movie.new(:rating => 'PG', :length_minutes => '10')
    test_for_db_error("Database did not catch null name") do
      movie.save!
    end
  end

  it "enforces name not empty" do
    movie = Movie.new(:name => '', :rating => 'PG', :length_minutes => '10')
    test_for_db_error("Database did not catch empty name") do
      movie.save!
    end
  end

  it "prevents duplicate entries" do
    movies = []

    2.times do
      movies << Movie.new(:name => 'Casablanca', :rating => 'PG', :length_minutes => '10')
    end

    test_for_db_error("Database did not catch duplicate movie") do
      movies[0].save!
      movies[1].save!
    end
  end

  it "enforces rating not null" do
    movie = Movie.new(:name => 'Casablanca', :length_minutes => '10')
    test_for_db_error("Database did not catch null rating") do
      movie.save!
    end
  end

  it "enforces rating datatype is an integer" do
    movie = Movie.new(:name => 'Casablanca', :rating => 'Fred',
                      :length_minutes => '10')
    test_for_db_error("Database did not catch invalid rating") do
      movie.save!
    end
  end

  it "enforces length is not null" do
    movie = Movie.new(:name => 'Casablanca', :rating => 'PG')
    test_for_db_error("Database did not catch null movie length") do
      movie.save!
    end
  end

  it "enforces length is greater than 0" do
    movie = Movie.new(:name => 'Casablanca', :rating => 'PG',
                      :length_minutes => '0')
    test_for_db_error("Database did not catch zero length movie") do
      movie.save!
    end
  end

  it "enforces length is not negative" do
    movie = Movie.new(:name => 'Casablanca', :rating => 'PG',
                      :length_minutes => '-10')
    test_for_db_error("Database did not catch negative movie length") do
      movie.save!
    end
  end
end
