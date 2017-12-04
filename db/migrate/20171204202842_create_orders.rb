class CreateOrders < ActiveRecord::Migration
  def up
    execute <<-SQL
        create sequence orders_id_seq;
        create table orders (
          id integer not null
            default nextval('orders_id_seq'),
          confirmation_code varchar(256) not null unique
            check (length(confirmation_code) > 0),
          movie_showtime_id integer not null
            references movie_showtimes(id),
          payment_type_id integer not null,
          credit_card_number integer not null,
          expiration_date timestamp with time zone not null,
          primary key (id)
        )inherits(addresses);
    SQL
  end

  def down
    execute <<-SQL
      drop table orders;
      drop sequence orders_id_seq;
    SQL
  end
end
