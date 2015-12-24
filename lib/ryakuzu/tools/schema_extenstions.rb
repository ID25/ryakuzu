module Ryakuzu
  module SchemaExtenstions
    require 'virtus'
    require 'csv'
    require 'fileutils'

    attr_reader :file, :schema, :schema_hash

    private

    def table_field(table)
      table.delete("\"").delete(',') if table
    end

    def column_field(field)
      field.delete("\",").chomp('t.') if field
    end
  end
end
