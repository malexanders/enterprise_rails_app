require 'rails_helper'

RSpec.describe MovieShowtime, type: :model do
  let(:theatre) { create :theatre }
  let(:movie) { create :movie }

  context "Database Layer Validations", database_specs: true do
    it "validates presence of movie id" do
      st = build :movie_showtime, theatre: theatre, movie: nil
      test_for_db_error "Database allowed save with no movie." do
        st.save(validation: false)
      end
    end

    it "validates presence of theatre id" do
      st = build :movie_showtime, movie: movie, theatre: nil
      test_for_db_error "Database allowed save with no theatre" do
        st.save(validation: false)
      end
    end

    it "validates presence of auditorium" do
      st = build :movie_showtime, movie: movie, theatre: theatre, auditorium: nil
      test_for_db_error "Database allowed save with no theatre" do
        st.save(validation: false)
      end
    end

    it "validates length of auditorium" do
      st = build :movie_showtime, movie: movie, theatre: theatre, auditorium: "123451234512345678"
      test_for_db_error "Database allowed save with auditorium length greater than 16" do
        st.save(validation: false)
      end
    end

    it "validates auditorium length is greater than 0" do
      st = build :movie_showtime, movie: movie, theatre: theatre, auditorium: ""
      test_for_db_error "Database allowed save with auditorium length equal to 0" do
        st.save(validation: false)
      end
    end

    it "validates presence of start time" do
      st = build :movie_showtime, movie: movie, theatre: theatre, start_time: nil
      test_for_db_error "Database allowed save with no start time" do
        st.save(validation: false)
      end
    end

    it "validates associated movie is valid" do
      st = build :movie_showtime, movie_id: (Movie.count + 2), theatre: theatre
      test_for_db_error "Database allowed save with invalid movie" do
        st.save(validation: false)
      end
    end

    it "validates associated theatre is valid" do
      st = build :movie_showtime, movie: movie, theatre_id: (Theatre.count + 2)
      test_for_db_error "Database allowed save with invalid theatre" do
        st.save(validation: false)
      end
    end

    it "validates reference movie may not be deleted" do
      create :movie_showtime, movie: movie, theatre: theatre
      test_for_db_error "Database allowed referenced theatre to be deleted" do
        theatre.delete
      end
    end

    it "validates reference theatre may not be deleted" do
      create :movie_showtime, movie: movie, theatre: theatre
      test_for_db_error "Database allowed referenced theatre to be deleted" do
        movie.delete
      end
    end
  end

  context "Application Layer Validations" do
    it "validates presence of movie id" do
      st = build :movie_showtime, theatre: theatre, movie: nil
      expect(!st.save).to be(true), "Model validation allowed save with no movie"
    end

    it "validates presence of theatre id" do
      st = build :movie_showtime, movie: movie, theatre: nil
      expect(!st.save).to be(true), "Model validation allowed save with no theatre"
    end

    it "validates length of auditorium" do
      st = build :movie_showtime, movie: movie, theatre: theatre, auditorium: "123451234512345678"
      expect(!st.save).to be(true), "Model validation did not check length of auditorium field"
    end

    it "validates auditorium length is greater than 0" do
      st = build :movie_showtime, movie: movie, theatre: theatre, auditorium: ""
      expect(!st.save).to be(true), "Model validation allowed save with auditorium length not greater than 0"
    end

    it "validates presence of start time" do
      st = build :movie_showtime, movie: movie, theatre: theatre, start_time: nil
      expect(!st.save).to be(true), "Model validation allowed save without start_time"
    end

    it "validates valid movie reference" do
      st = build :movie_showtime, movie_id: (Movie.count + 2), theatre: theatre
      expect(!st.save).to be(true), "Model validation allowed save with invalid movie"
    end

    it "validates valid theatre reference" do
      st = build :movie_showtime, movie: movie, theatre_id: (Theatre.count + 2)
      expect(!st.save).to be(true), "Model validation allowed save with invalid theatre"
    end

    it "validates presence of auditorium" do
      st = build :movie_showtime, movie: movie, theatre: theatre, auditorium: nil
      expect(!st.save).to be(true), "Model validation allowed save with no auditorium"
    end

    it "validates associated movie shotimes are deleted when theatre is deleted" do
      create :movie_showtime, movie: movie, theatre: theatre
      expect { theatre.destroy }.to change { MovieShowtime.count }.by(-1)
    end

    it "validates associated movie shotimes are deleted when movie is deleted" do
      create :movie_showtime, movie: movie, theatre: theatre
      expect { movie.destroy }.to change { MovieShowtime.count }.by(-1)
    end
  end
end