class CreateTheatres < ActiveRecord::Migration
  def up
    execute <<-SQL
    create sequence theatres_id_seq;
    create table theatres (
      id integer,
      name varchar(256),
      phone_number varchar(10),
      primary key (id)
    )inherits(addresses);
    SQL
  end

  def down
    execute <<-SQL
      drop table theatres;
      drop sequence theatres_id_seq;
    SQL
  end
end
