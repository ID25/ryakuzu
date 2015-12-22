module Ryakuzu
  module SchemaExtenstions
    require 'virtus'
    require 'csv'
    require 'fileutils'

    attr_reader :file, :schema, :schema_hash

    private

    def table_name(table)
      table.delete("\"").delete(',')
    end

    def field_name(field)
      field.delete("\",").chomp('t.')
    end
  end
end
