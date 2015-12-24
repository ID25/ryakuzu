module Ryakuzu
  class SchemaService
    include Ryakuzu::SchemaExtenstions

    def initialize
      @file        = File.open(Rails.root.join('db', 'schema.rb'))
      @schema_hash = Ryakuzu::Ripper.parse(file)
    end

    def call
      schema_hash.each_with_object([]) { |schema, klass| klass << Ryakuzu::Table.generate_models(schema[0], schema[1]) }
    end

    def schema_to_csv
      CSV.open('schema.csv', 'wb') { |csv| schema_hash.to_a.map { |elem| csv << elem } }
    end
  end
end
