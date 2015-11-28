class ColumnDefaults < Schema
  attribute :default, String
  attribute :type,    String
  attribute :null,    String

  class << self
    def generate_object(default, type, null)
      result = case default
        when nil then 'nil'
        when "" then '""'
        else default
      end
      ColumnDefaults.new(default: result, type: type, null: null)
    end
  end
end
