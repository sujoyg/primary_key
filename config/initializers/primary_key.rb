class ActiveRecord::Migration
  class CommandRecorder
    def add_primary_key(*args)
      record(:add_primary_key, args)
    end

    def invert_add_primary_key(args)
      [:remove_primary_key, [args[0]]]
    end
  end
end

ActiveRecord::Base.connection.execute('SELECT 1')  # Loads the MySQL adapter.

class ActiveRecord::ConnectionAdapters::Mysql2Adapter
  def add_primary_key(table, *columns)
    execute "ALTER TABLE #{table} ADD PRIMARY KEY (#{columns.join(', ')})"
  end

  def remove_primary_key(table)
    execute "ALTER TABLE #{table} DROP PRIMARY KEY"
  end
end


class ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter
  # Returns a table's primary key and belonging sequence.
  def composite_primary_key(table)
    execute_and_free("SHOW CREATE TABLE #{quote_table_name(table)}", 'SCHEMA') do |result|
      create_table = each_hash(result).first[:"Create Table"]
      if create_table.to_s =~ /PRIMARY KEY\s+(?:USING\s+\w+\s+)?\((.+)\)/
        $1.split(',').map { |key| key.gsub(/[`"]/, "") }
      end
    end
  end
end

class ActiveRecord::SchemaDumper
  def indexes_with_primary_key(table, stream)
    pk = @connection.composite_primary_key(table)
    if pk && pk.size > 1
      stream.puts "  add_primary_key \"#{table}\", #{pk}"
      stream.puts
    end

    indexes_without_primary_key(table, stream)
  end

  alias_method_chain :indexes, :primary_key
end