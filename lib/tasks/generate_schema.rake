# I created this task so that I could create tables that are inherited
# I found that using the alter instruction to add inheritance was quite finicky
# This was an acceptable work around for this exercise

namespace :schema do
  desc "Build db"
  task create: [:create_addresses] do
  end

  task drop: [:create_addresses] do
  end

  task create_addresses: :environment do
    unless ActiveRecord::Base.connection.table_exists? :addresses
      ActiveRecord::Base.connection.execute(<<-SQL)
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
    else
      puts "Addresses already exists"
    end
  end

  task drop_addresses: :environment do
    if ActiveRecord::Base.connection.table_exists? :addresses
      ActiveRecord::Base.connection.execute(<<-SQL)
        drop table addresses;
      SQL
    end
  end
end
