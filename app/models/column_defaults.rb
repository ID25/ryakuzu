class ColumnDefaults < Schema
  attribute :table,   String
  attribute :column,  String
  attribute :default, String
  attribute :type,    String
  attribute :null,    String
  attribute :index,   Boolean

  class << self
    def generate_object(table, column, default, type, null, index)
      result = case default
        when nil then 'nil'
        when "" then '""'
        else default
      end
      ColumnDefaults.new(table: table, column: column, default: result, type: type, null: null, index: index)
    end
  end
end
