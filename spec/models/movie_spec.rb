require 'rails_helper'

RSpec.describe Movie, type: :model do
  context "Database Layer Validations" do
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

    it "enforces non duplicate entries" do
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

    it "enforces rating datatype is a valid" do
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

  context "Application Layer Validations" do
    it "enforces name not null" do
      movie = Movie.new(:rating => 'PG', :length_minutes => '10')
      expect(movie.save).to be(false), "Model constraints did not catch null name"
    end

    it "enforces name not empty" do
      movie = Movie.new(:name => '', :rating => 'PG', :length_minutes => '10')
      expect(movie.save).to be(false), "Model constraints did not catch empty name"
    end

    it "enforces non duplicate entries" do
      movies = []

      2.times do
        movies << Movie.new(:name => 'Casablanca', :rating => 'PG', :length_minutes => '10')
      end

      movies[0].save
      expect(movies[1].save).to be(false), "Model constraints did not catch duplicate movie"
    end

    it "enforces rating not null" do
      movie = Movie.new(:name => 'Casablanca', :length_minutes => '10')
      expect(movie.save).to be(false), "Model constraints did not catch null rating"
    end

    it "enforces rating datatype is a valid" do
      movie = Movie.new(:name => 'Casablanca', :rating => 'Fred',
                        :length_minutes => '10')
      expect(movie.save).to be(false), "Model constraints did not catch invalid rating"
    end

    it "enforces length is not null" do
      movie = Movie.new(:name => 'Casablanca', :rating => 'PG')
      expect(movie.save).to be(false), "Model constraints did not catch null movie length"
    end

    it "enforces length is greater than 0" do
      movie = Movie.new(:name => 'Casablanca', :rating => 'PG',
                        :length_minutes => '0')
      expect(movie.save).to be(false), "Model constraints did not catch zero length movie"
    end

    it "enforces length is not negative" do
      movie = Movie.new(:name => 'Casablanca', :rating => 'PG', :length_minutes =>
          '−10')
      expect(movie.save).to be(false), "Model constraints did not catch negative movie length"
    end

  end
end
