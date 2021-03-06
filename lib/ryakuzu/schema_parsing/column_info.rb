module Ryakuzu
  class ColumnInfo
    include Ryakuzu::SchemaExtenstions

    def initialize
      @file   = File.open(Rails.root.join('db', 'schema.rb'))
      @schema = Ryakuzu::Ripper.parse(file)
    end

    def call(table, column)
      columns = parse_schema(table, column)
      Ryakuzu::Column.new(columns.symbolize_keys).column_defaults
    end

    private

    def parse_schema(table, column)
      file.each do |line|
        parts = line.split ' '
        next if parts.nil? || parts.length < 1 || parts[0] == '#'
        @table_name = table_field(parts[1]) if parts[0] == 'create_table'

        next unless @table_name == table
        @field_name = column_field(parts[1]) if parts[0][0] == 't'

        next unless @field_name == column
        return columns_info(parts, @table_name)
      end
    end

    def columns_info(parts, table_name)
      parts[0][0] = ''
      schema.each do |schema_line|
        schema_line[1].each do |part|
          next unless part == column_field(parts[1])
          next unless parts[1]
          hash        = remove_extra_chars(parts[0..1])
          column      = column_and_type(hash, table_name)
          words       = default_words(parts[2..parts.count])
          temporary   = make_hash(words) if words
          return column.merge!(temporary)
        end
      end
    end

    def remove_extra_chars(lines)
      lines.map { |e| e.gsub(/\W/, '') }
    end

    def column_and_type(lines, table_name)
      { table: table_name, type: lines[0], column: lines[1] }
    end

    def make_hash(parameters)
      temporary = {}
      parameters.each_slice(2) do |slice|
        temporary.merge!(Hash[*slice])
      end
      temporary
    end

    def default_words(words)
      value = remove_extra_chars(words)
      if value.count > 1
        value[2..value.count].each do |word|
          temp = value[1] + ' '
          temp.concat(word)
          value[1] = temp
          value[2..value.count] = nil
          value.reject!(&:nil?)
        end
      end
      value
    end
  end
end
