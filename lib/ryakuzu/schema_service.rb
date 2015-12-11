module Ryakuzu
  class SchemaService
    include Ryakuzu::SchemaExtenstions

    def initialize
      @file     = File.readlines('./db/schema.rb')
      @schema   = ''
      @sch_hash = {}
    end

    def call
      parse_schema
      create_hash_from_schema
    end

    def hash
      call
      models = []
      sch_hash.map { |key, value| models << Ryakuzu::Table.generate_models(key, value) }
      models
    end

    def schema_to_csv
      CSV.open('schema.csv', 'wb') { |csv| sch_hash.to_a.map { |elem| csv << elem } }
    end

    private

    def parse_schema
      file.each do |line|
        parts = line.split ' '
        next if parts.nil? || parts.length < 1 || parts[0] == '#'
        if parts[0] == 'create_table'
          table_name = table_name(parts[1])
          schema << "__#{table_name},"
        end

        if parts[0][0] == 't'
          field_name = field_name(parts[1])
          schema << "#{field_name}__"
        end
      end
    end

    def create_hash_from_schema
      return if sch_hash.present?
      array      = convert_source
      hash_array = convert_to_hash(array)

      hash_array.each_with_index do |i, _v|
        sch_hash.merge!(i[0] => i.reject { |k| k == i[0] })
      end
    end

    def convert_source
      @schema = schema.split('__').join(',')
      schema[0] = ''
      schema.split(',,')
    end

    def convert_to_hash(array)
      arr_m = []
      array.map { |k, _v| arr_m << k.split(',') }
      arr_m
    end
  end
end
