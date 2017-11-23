class CreateMovies < ActiveRecord::Migration
  def up
    execute <<-SQL
      create sequence movies_id_seq;
      create table movies (
        id integer,
        name varchar(256),
        length_minutes integer,
        rating varchar(8),
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
