class CreateAuditoria < ActiveRecord::Migration
  def up
    execute <<-SQL
      create sequence auditoria_id_seq;
      create table auditoria (
        id integer not null
          default nextval('auditoria_id_seq'),
        theatre_id integer not null
          references theatres(id),
        auditorium_identifier varchar(64) not null
          check (length(auditorium_identifier) >= 1),
        seats_available integer not null,
        unique(theatre_id, auditorium_identifier),
        primary key (id)
      );
    SQL
  end

  def down
    execute <<-SQL
      drop table auditoria;
      drop sequence auditoria_id_seq;
    SQL
  end
end
