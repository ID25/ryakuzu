module Ryakuzu
  class ColumnInfo
    attr_accessor :file, :schema

    def initialize
      file    = File.open('./db/schema.rb')
      @file   = file
      @schema = Ryakuzu::Ripper.parse(file)
    end

    def call(table, column)
      file.each do |line|
        parts = line.split ' '
        next if parts.nil? || parts.length < 1 || parts[0] == '#'
        if parts[0] == 'create_table'
          @table_name = parts[1].delete("\"").delete(',')
        end

        next unless @table_name == table
        @field_name = parts[1].delete("\",").chomp('t.') if parts[0][0] == 't'
        next unless @field_name == column
        parts[0][0] = ''
        schema.each do |schema_line|
          schema_line[1].each do |part|
            next unless part == parts[1].delete("\",").chomp('t.')
            next unless parts[1]
            hash        = remove_extra_chars(parts[0..1])
            column      = column_and_type(hash, @table_name)
            size        = parts[2..parts.count]
            parameters  = remove_extra_chars(size)
            temporary   = make_hash(parameters)
            @columns    = column.merge!(temporary)
          end
        end
      end
      Ryakuzu::Column.new(@columns.symbolize_keys).column_info
    end

    private

    def remove_extra_chars(lines)
      lines.map { |e| e.gsub(/\W/, '') }
    end

    def column_and_type(lines, table_name)
      { table: table_name, type: lines[0], column: lines[1] }
    end

    def make_hash(parameters)
      temporary = {}
      unless parameters.empty?
        parameters.each_slice(2) do |slice|
          temporary.merge!(Hash[*slice])
        end
      end
      temporary
    end
  end
end
