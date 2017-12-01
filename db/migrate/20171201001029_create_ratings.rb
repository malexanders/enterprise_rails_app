class CreateRatings < ActiveRecord::Migration
  def up
    execute <<-SQL
      create sequence ratings_id_seq;
      create table ratings (
        id integer not null
          default nextval('ratings_id_seq'),
        rating_name varchar(16)
          check (length(rating_name) > 0),
        rating_description text,
        primary key (id)
      );
    SQL
  end

  def down
    execute <<-SQL
      drop table ratings;
      drop sequence ratings_id_seq;
    SQL
  end
end
