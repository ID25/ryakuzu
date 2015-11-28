class Table < Schema
  include Virtus.relations(as: :table)

  attribute :name, String
  attribute :column, Column, relation: true

  class << self
    def generate_models(key, value)
      hash_handler(key, value, false)
    end

    def create_model(schema)
      hash_handler(schema['name'], schema['column'], true)
    end

    def hash_handler(table_name, kolumn, index)
      table  = Table.new(name: table_name)
      column = Column.new
      column.extend(Virtus.model)
      kolumn.each_with_index do |value, indx|
        column.attribute "column_#{indx}".to_sym, String, default: (index == true) ? value[1] : value, lazy: true
      end
      table.column = column
      table
    end
  end
end
