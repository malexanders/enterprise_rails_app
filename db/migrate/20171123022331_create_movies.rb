class CreateMovies < ActiveRecord::Migration
  def up
    execute <<-SQL
      create sequence movies_id_seq;
      create table movies (
        id integer not null
          default nextval('movies_id_seq'),
        name varchar(256) not null unique
          check (length(name) > 0),
        length_minutes integer not null
          check (length_minutes > 0),
        primary key (id)
      );
    SQL
  end

  def down
    execute <<-SQL
      drop table movies;
      drop sequence movies_id_seq;
    SQL
  end
end
