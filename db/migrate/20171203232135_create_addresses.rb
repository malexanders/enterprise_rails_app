# Does not relate to model class
# This table will be inherited to other tables that required address fields
# TODO Add zip code table later and include foreign key reference
class CreateAddresses < ActiveRecord::Migration
  def up
    execute <<-SQL
      create table addresses ( line_1 varchar(256) not null
        check (length(line_1) > 0), line_2 varchar(256),
      city varchar(128) not null
        check (length(city) > 0),
      state varchar(2) not null
        check (length(state) = 2),
      zip_code varchar(9) not null
        check (length(zip_code) >= 6),
      phone_number varchar(10) not null
        check (length(phone_number) = 10)
      );
    SQL
  end

  def down
    execute <<-SQL
      drop table addresses;
    SQL
  end
end
