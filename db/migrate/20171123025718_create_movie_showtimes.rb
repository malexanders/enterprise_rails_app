class CreateMovieShowtimes < ActiveRecord::Migration
  def up
    execute <<-SQL
      create sequence movie_showtimes_id_seq;
      create table movie_showtimes (
        id integer not null
          default nextval('movie_showtimes_id_seq'),
        movie_id integer not null
          references movies(id),
        theatre_id integer not null
          references theatres(id),
        auditorium varchar(16) not null
           check (length(auditorium) > 0),
        start_time timestamp with time zone not null,
        primary key (id)
      );
      create index movie_showtimes_movie_id_idx on movie_showtimes(movie_id);
      create index movie_showtimes_theatre_id_idx on movie_showtimes(theatre_id);
      create index theatres_zip_idx on theatres(zip_code);
      create index movie_showtimes_start_time_idx on movie_showtimes(start_time);
    SQL
  end

  def down
    execute <<-SQL
      drop table movie_showtimes;
      drop sequence movie_showtimes_id_seq;
    SQL
  end
end
